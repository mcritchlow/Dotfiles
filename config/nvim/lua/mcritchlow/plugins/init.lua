-- Ensure paq is installed
-- Auto install packer.nvim if not exists
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end
vim.cmd [[packadd packer.nvim]]

local ok, packer = pcall(require, "packer")

if not ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
    prompt_border = "single",
  },
  git = {
    clone_timeout = 600,
  },
  auto_clean = true,
  compile_on_sync = false,
}

return packer.startup(function(use)

  -- Theme
  use { "projekt0n/github-nvim-theme" }

  -- Utils
  use { "tpope/vim-repeat" }
  use { "tpope/vim-unimpaired" }
  use { "tpope/vim-markdown", config = require "mcritchlow.plugins.config.markdown" }
  use { "tpope/vim-fugitive" }
  use { "whiteinge/diffconflicts" }
  use { "christoomey/vim-sort-motion" }
  use { "ggandor/lightspeed.nvim" }
  use { "folke/lua-dev.nvim" }
  use { "ThePrimeagen/harpoon", config = require "mcritchlow.plugins.config.harpoon" }
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = require "mcritchlow.plugins.configs.nvimtree"
  }

  -- Testing
  use { "vim-test/vim-test", config = require "mcritchlow.plugins.config.vim_test" }

  -- Keymapping fancy fancy
  use { "folke/which-key.nvim" }

  -- Comment
  use { "numToStr/Comment.nvim", config = require "mcritchlow.plugins.config.comment" }

  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      "https://git.sr.ht/~mcritchlow/cmp-gitlab-issues",
      "https://git.sr.ht/~mcritchlow/cmp-jira-issues",
      "kyazdani42/nvim-web-devicons",
      "rafamadriz/friendly-snippets",
    },
    config = require "mcritchlow.plugins.configs.cmp",
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "cwebster2/github-coauthors.nvim"
    },
    config = require "mcritchlow.plugins.configs.telescope",
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- LSP
  use {
    "williamboman/nvim-lsp-installer",
    requires = {
      "neovim/nvim-lspconfig",
      "b0o/SchemaStore.nvim",
      "onsails/lspkind-nvim",
    },
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }
  use { "folke/trouble.nvim", config = require "mcritchlow.plugins.config.trouble" }

  -- Text Object stuff
  use { "kana/vim-textobj-user" }
  use { "kana/vim-textobj-indent" }
  use { "nelstrom/vim-textobj-rubyblock" }

  -- Syntax
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/playground",
      "RRethy/nvim-treesitter-textsubjects"
    },
    run = ":TSUpdate",
    config = require "mcritchlow.plugins.config.treesitter",
  }
  use { "norcalli/nvim-colorizer.lua", config = require "mcritchlow.plugins.config.colorizer" }
  use { "sheerun/vim-polyglot" }
  use { "vim-ruby/vim-ruby" }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
