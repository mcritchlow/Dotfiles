local _M = {}

-- Support dynamically reloading lua modules in config
_M.reload_module = function(name)
    local ok, plenary = pcall(require, "plenary.reload")
    if not ok then
        return
    end
    plenary.reload_module(name)
    require(name)
end

-- Setup vim-test for container name in docker-compose
-- @parameter service -- docker service name (usually app or web)
_M.setup_vim_test = function(service)
    vim.g["test#ruby#rspec#executable"] = "docker-compose-test " .. service
end

-- Setup null-ls to use standardrb for lint/format
-- @parameter service -- docker service name (usually app or web)
-- @parameter cwd_suffix -- subpath to project if not in the root of git repo (surfliner)
_M.setup_null_ls = function(service, cwd_suffix)
    cwd_suffix = cwd_suffix or ""
    -- Null-ls configuration
    local null_ls = require("null-ls")
    local util = require("null-ls.utils")

    local null_ls_sources = {
        null_ls.builtins.diagnostics.standardrb.with({
            cwd = function(params)
                return util.root_pattern(".git")(vim.fn.getcwd()) .. cwd_suffix
            end,
            command = "docker-compose-exec",
            args = { service, "bundle", "exec", "standardrb", " --no-fix", "-f", "json", "--stdin", "$FILENAME" },
        }),
        null_ls.builtins.formatting.standardrb.with({
            command = "docker-compose-exec",
            args = { service, "bundle", "exec", "standardrb", " --fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
        }),
    }
    null_ls.register(null_ls_sources)

end

-- Example usage
-- utils.set_spaces_size{ go = 4, ruby = 2, python = 4, java = 4 }
_M.set_spaces_size = function(filetypes)
    for filetype, size in pairs(filetypes) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetype,
            callback = function()
                vim.opt.shiftwidth = size
                vim.opt.tabstop = size
            end,
        })
    end
end

-- Signs for tree view, diagnostics, etc
_M.signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

-- Get the index of an array/list item
-- Example usage
-- utils.index_of(my_array, "an-item") -> 3
_M.index_of = function(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

-- Replace term codes using preset settings
-- Example usage
-- utils.replace_term_codes("<Esc>")
_M.replace_term_codes = function(value)
    return vim.api.nvim_replace_termcodes(value, true, true, true)
end

return _M
