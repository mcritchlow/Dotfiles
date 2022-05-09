local _M = {}

-- Example usage
-- utils.setSpacesSize{ go = 4, ruby = 2, python = 4, java = 4 }
_M.setSpacesSize = function(filetypes)
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

-- Get the index of an array/list item
-- Example usage
-- utils.indexOf(my_array, "an-item") -> 3
_M.indexOf = function(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

-- Replace term codes using preset settings
-- Example usage
-- utils.replaceTermCodes("<Esc>")
_M.replaceTermCodes = function(value)
  return vim.api.nvim_replace_termcodes(value, true, true, true)
end

return _M
