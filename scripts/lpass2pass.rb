#! /usr/bin/env ruby
#
# Usage:
#   Run with: lpass ls | awk '{print $(NF)}' | sed 's/\]//g' | head -n 2 | xargs lpass show --all --json | ./lpass2pass.rb
#   Eventually this will move to a bin/sync-lpass-pass script or something
#
# JSON format
# [
  # {
  #   "id": "something",
  #   "name": "",
  #   "fullname": "Cloud/amazon.com",
  #   "username": "",
  #   "password": "",
  #   "last_modified_gmt": "1541431585",
  #   "last_touch": "0",
  #   "group": "Cloud",
  #   "url": "http://group",
  #   "note": ""
  # }
# ]
require 'json'

json_input = ''
$stdin.each_line do |line|
  json_input << line
end
sites = JSON.parse(json_input, symbolize_names: true)
sites.each do |site|
  next if site[:url].eql?('http://group')
  if url.eql?('http://sn')
    # Notes only have a note field, surprise!
    puts site[:note]
  else
    puts [site[:password], '----',
    "url: #{site[:url]}",
    "username: #{site[:username]}",
    "note: #{site[:note]}"].join("\n") + "\n"
  end

end



# parse json input from stdin
# for each object, construct a pass compatible multi-line string.
# example:
#
# Yw|ZSNH!}z"6{ym9pI
# URL: *.amazon.com/*
# Username: AmazonianChicken@example.com
# Secret Question 1: What is your childhood best friend's most bizarre superhero fantasy? Oh god, Amazon, it's too awful to say...
# Phone Support PIN #: 84719
#

# if there is no ~/.last_pass_sync file, create one with GMT timestamp, use timestamp in variable
# for each record modified before the timestamp, create a pass entry and enter it
# example:
#
# IO.popen("pass insert -m '#{r.name}' > /dev/null", 'w') do |io|
#   io.puts r.to_s
# end
