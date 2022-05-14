require("mcritchlow.settings")
require("mcritchlow.plugins")
require("mcritchlow.mappings")
require("mcritchlow.autocommands")
require("mcritchlow.commands")

-- Workaround since neovim doesn't support .nvimrc files
-- We use lua files instead, since we are making our own solution
local local_vimrc = vim.fn.getcwd()..'/nvim-local.lua'
if vim.loop.fs_stat(local_vimrc) then
  vim.cmd('source '..local_vimrc)
end
