#!/usr/bin/env ruby
require 'English'

# Copyright (C) 2012 Alex Sayers <alex.sayers@gmail.com>. All Rights Reserved.
# This file is licensed under the GPLv2+. Please see COPYING for more information.
# Modified by Matt Critchlow to take in a stream from lastpass-cli via lpass-export

# LastPass Importer
#
# Reads CSV export from LastPass CLI envoked via: `lpass export`

# Usage:
# Install lastpass-cli and authenticate as needed
#
# Fire up a terminal and run the script, passing the file you saved as an argument.
# It should look something like this:
#
# $ lpass export | ./lastpass2pass.rb

# Parse flags
require 'optparse'
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: lpass export | #{$0} [options]"

  FORCE = false
  opts.on("-f", "--force", "Overwrite existing records") { FORCE = true }
  DEFAULT_GROUP = ""
  opts.on("-d", "--default GROUP", "Place uncategorised records into GROUP") { |group| DEFAULT_GROUP = group }
  opts.on("-h", "--help", "Display this screen") { puts opts; exit }

  opts.parse!
end

class LPassRecord
  def name
    s = ""
    s << @grouping + "/" unless @grouping.empty?
    s << @name unless @name.nil?
    s.gsub(/ /, "_").gsub(/'/, "")
  end
end

class Note < LPassRecord
  def initialize(name, grouping, note)
    @name = name
    @grouping = grouping
    @note = note
  end

  def to_s
    s = ""
    s << "#{@note}\n---\n"
    s << "#{@grouping} / " unless @grouping
    s << "#{@name}\n"
    s
  end
end

class Site < LPassRecord
  def initialize name, url, username, password, extra, grouping, fav
    @name, @url, @username, @password, @extra, @grouping, @fav = name, url, username, password, extra, grouping, fav
  end

  def to_s
    s = ""
    s << "#{@password}\n---\n"
    s << "#{@grouping} / " unless @grouping.empty?
    s << "#{@name}\n"
    s << "username: #{@username}\n" unless @username
    s << "password: #{@password}\n" unless @password
    s << "url: #{@url}\n" unless @url == "http://sn"
    s << "#{@extra}\n" unless @extra.nil?
    s
  end
end

# Extract individual records
entries = []
entry = ""
# So far, LastPass has 7 fields in the CSV, so 7-1 for delimiters
TOTAL_DELIMITERS = 7

$stdin.each_line do |line|
  if line =~ /^(http|ftp|ssh)/ && entry.split(',').size >= TOTAL_DELIMITERS
    entries.push(entry)
    entry = ""
  end
  entry += line
end
entries.push(entry)
entries.shift
puts "#{entries.length} records found!"

# Parse records and create LPass objects
records = []
entries.each do |e|
  args = e.split(',')
  url = args.shift
  username = args.shift
  password = args.shift
  fav = args.pop
  grouping = args.pop
  grouping = DEFAULT_GROUP if grouping.nil?
  name = args.pop
  extra = args.join(',')[1...-1]

  # Determine if record is a Site or Secure Note
  if url.eql?('http://sn')
    records << Note.new(name, grouping, extra)
  else
    records << Site.new(name, url, username, password, extra, grouping, fav)
  end
end
puts "Records parsed: #{records.length}"

successful = 0
errors = []
records.each do |r|
  if File.exist?("#{r.name}.gpg") && FORCE == false
    puts "skipped #{r.name}: already exists"
    next
  end
  print "Creating record #{r.name}..."
  IO.popen("pass insert -m '#{r.name}' > /dev/null", 'w') do |io|
    io.puts r.to_s
  end
  if $CHILD_STATUS == 0
    puts ' done!'
    successful += 1
  else
    puts ' error!'
    errors << r
  end
end
puts "#{successful} records successfully imported!"

unless errors.empty?
  puts "There were #{errors.length} errors:"
  errors.each { |e| print e.name + (e == errors.last ? ".\n" : ", ")}
  puts 'These probably occurred because an identically-named record already existed, or because there were multiple entries with the same name in the csv file.'
end
