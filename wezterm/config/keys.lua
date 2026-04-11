local M = {}

function M.apply(config, wezterm)
  local act = wezterm.action

  config.leader = {
    key = "a",
    mods = "CTRL",
    timeout_milliseconds = 1200,
  }

  config.keys = {
    {
      key = "Space",
      mods = "LEADER",
      action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES|TABS|LAUNCH_MENU_ITEMS" }),
    },
    {
      key = "w",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = "New workspace name",
        action = wezterm.action_callback(function(window, pane, line)
          if line and #line > 0 then
            window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
          end
        end),
      }),
    },

    { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
    { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
    { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },

    { key = "t", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "b", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "r", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

    { key = "T", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "B", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "R", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
    {
      key = ",",
      mods = "LEADER",
      action = act.PromptInputLine({
        description = "Rename tab title",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      }),
    },
  }
end

return M
