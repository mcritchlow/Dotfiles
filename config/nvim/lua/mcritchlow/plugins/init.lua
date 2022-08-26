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
  compile_on_sync = true
}

return packer.startup(function(use)
  use { "wbthomason/packer.nvim" }

  -- Theme
  use { "projekt0n/github-nvim-theme" }

  -- Utils
  use { "tpope/vim-repeat" }
  use { "tpope/vim-markdown", config = function()
    require("mcritchlow.plugins.config.markdown")
  end }
  use {"ellisonleao/glow.nvim", branch = 'main'}
  use { "tpope/vim-fugitive" }
  use { "tpope/vim-surround" }
  use { "whiteinge/diffconflicts" }
  use { "christoomey/vim-sort-motion" }
  use { "folke/lua-dev.nvim" }
  use { "ThePrimeagen/harpoon", config = function()
    require("mcritchlow.plugins.config.harpoon")
  end }
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("mcritchlow.plugins.config.nvimtree")
    end
  }
  use { "gpanders/editorconfig.nvim" }

  -- Testing
  use { "vim-test/vim-test", config = function()
    require("mcritchlow.plugins.config.vim_test")
  end }

  -- Keymapping fancy fancy
  use { "folke/which-key.nvim" }

  -- Comment
  use { "numToStr/Comment.nvim", config = function()
    require("mcritchlow.plugins.config.comment")
  end }

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
    config = function()
      require("mcritchlow.plugins.config.cmp")
    end
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "cwebster2/github-coauthors.nvim",
      "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
      require("mcritchlow.plugins.config.telescope")
    end
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- LSP
  use { "b0o/SchemaStore.nvim" }
  use { "onsails/lspkind-nvim" }
  use {
    "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mcritchlow.lsp")
    end
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }
  use { "folke/trouble.nvim", config = function()
    require("mcritchlow.plugins.config.trouble")
  end }

  -- Text Object stuff
  use { "kana/vim-textobj-user" }
  use { "kana/vim-textobj-indent" }
  use { "nelstrom/vim-textobj-rubyblock" }

  use { "ray-x/go.nvim", config = function()
    require("mcritchlow.plugins.config.go")
  end }

  use { "ray-x/lsp_signature.nvim", config = function()
    require("mcritchlow.plugins.config.lsp_signature")
  end }

  -- Syntax
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    run = ":TSUpdate",
    config = function()
      require("mcritchlow.plugins.config.treesitter")
    end
  }
  use { "norcalli/nvim-colorizer.lua", config = function()
    require("mcritchlow.plugins.config.colorizer")
  end }
  use { "sheerun/vim-polyglot" }
  use { "vim-ruby/vim-ruby" }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
