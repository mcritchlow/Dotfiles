local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
  return
end

local ts_languages = {
  "bash",
  "dockerfile",
  "go",
  "help",
  "java",
  "javascript",
  "json",
  "lua",
  "make",
  "python",
  "ruby",
  "rust",
  "scss",
  "vim",
  "yaml"
}

treesitter.setup {
  ensure_installed = ts_languages,
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "ruby" }, -- list of language that will be disabled
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    }
  },
}
