local _M = {}

_M.init = function()
  local themeLoaded, github = pcall(require, "github-theme")
  if themeLoaded then
    github.setup({
      theme_style = "light",
      hide_inactive_statusline = false
    })
  end
end

return _M
