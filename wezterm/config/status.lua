local M = {}

function M.setup(wezterm)
  wezterm.on("update-right-status", function(window, pane)
    local workspace = window:active_workspace()
    local host = wezterm.hostname()
    local date = wezterm.strftime("%a %b %-d %H:%M")

    window:set_right_status(wezterm.format({
      { Foreground = { Color = "#89b4fa" } },
      { Text = "  " .. workspace .. "  " },
      { Foreground = { Color = "#f5c2e7" } },
      { Text = "|  " .. host .. "  " },
      { Foreground = { Color = "#a6e3a1" } },
      { Text = "|  " .. date .. "  " },
    }))
  end)
end

return M
