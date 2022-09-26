local _M = {}

_M.init = function()
  local themeLoaded, github = pcall(require, "github-theme")
  if themeLoaded then
    github.setup({
      theme_style = "light_default",
      hide_inactive_statusline = false,
      sidebars = {'NvimTree'},
    })
  end
end

return _M
