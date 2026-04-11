local M = {}

function M.apply(config)
  config.automatically_reload_config = true
  config.audible_bell = "Disabled"
  config.adjust_window_size_when_changing_font_size = false
  config.scrollback_lines = 10000
end

return M
