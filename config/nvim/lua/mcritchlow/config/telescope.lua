-- TODO use fzf or fzy for extension??
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      width = 0.75,
      prompt_position = "bottom",
      preview_cutoff = 120,
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {
      "absolute",
    },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-x>"] = false,
          ["<C-q>"] = actions.send_to_qflist,
        },
    }
  }
}

M = {}

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = "$HOME/projects/personal/dotfiles",
  })
end

-- Action to get the git commit sha hash
local action_state = require('telescope.actions.state')
local function copy_commit_sha(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  vim.fn.setreg("+", selection.value)
  print("Copied commit: " .. selection.value .. " to clipboard")
end

-- Extend git_commits builtin with ability to copy commit hash
M.git_commits_with_sha = function()
  require("telescope.builtin").git_commits({ attach_mappings = function(_, map)
    map('i', '<c-y>', copy_commit_sha)
    map('n', '<c-y>', copy_commit_sha)
    return true
  end})
end

M.file_browser = function()
  require("telescope.builtin").file_browser({ attach_mappings = function(_, map)
    local function set_new_wd(prompt_bufnr)
      local dir = actions.get_selected_entry(prompt_bufnr).value
      vim.fn.execute("cd " .. dir, "silent")
      actions.close(prompt_bufnr)
      print("Change working directory to : " .. dir)
    end

    map('i', '<c-g>', set_new_wd)
    map('n', '<c-g>', set_new_wd)

    return true
  end})
end

return M
