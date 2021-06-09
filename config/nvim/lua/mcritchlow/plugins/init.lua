-- Ensure paq is installed
-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath('data')..'/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command('!git clone https://github.com/savq/paq-nvim.git '..install_path)
end
vim.cmd [[packadd paq-nvim]]

-- packages
require 'paq-nvim' {
  'ConradIrwin/vim-bracketed-paste';
  'bronson/vim-trailing-whitespace'; --make trailing whitespace annoying
  'editorconfig/editorconfig-vim';
  'folke/lua-dev.nvim';
  'glepnir/lspsaga.nvim';
  'hrsh7th/nvim-compe';
  'hrsh7th/vim-vsnip';
  'hrsh7th/vim-vsnip-integ';
  'janko-m/vim-test';
  'kana/vim-textobj-indent';
  'kana/vim-textobj-user';
  'nelstrom/vim-textobj-rubyblock';
  'neovim/nvim-lspconfig';
  'norcalli/nvim-colorizer.lua';
  'nvim-lua/plenary.nvim';
  'nvim-lua/popup.nvim';
  'nvim-telescope/telescope.nvim';
  'rafamadriz/friendly-snippets';
  'sainnhe/sonokai';
  'savq/paq-nvim';                  -- Let Paq manage itself
  'sheerun/vim-polyglot';
  'tpope/vim-endwise'; --" add end after if, do, def
  'tpope/vim-fugitive';
  'tpope/vim-markdown'; --add folding to markdown files
  'tpope/vim-rails';
  'tpope/vim-repeat'; -- repeat map commands (surround)
  'tpope/vim-unimpaired'; -- [ and ] mappings for quickfix, buffers, etc.
  'vim-ruby/vim-ruby';
  { 'junegunn/fzf', run=vim.fn['fzf#install()'] };
  { 'nvim-treesitter/nvim-treesitter', run=function() vim.cmd 'TSUpdate' end };
}
