local M = {}

function M.apply(config, wezterm)
  local fonts = {
    "JetBrains Mono",
  }

  local window_padding = {
    left = 16,
    right = 16,
    top = 14,
    bottom = 10,
  }

  local tab_bar_colors = {
    background = "#1e1e2e",
    active_tab = {
      bg_color = "#89b4fa",
      fg_color = "#1e1e2e",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#313244",
      fg_color = "#cdd6f4",
    },
    inactive_tab_hover = {
      bg_color = "#45475a",
      fg_color = "#f5e0dc",
    },
    new_tab = {
      bg_color = "#1e1e2e",
      fg_color = "#89b4fa",
    },
    new_tab_hover = {
      bg_color = "#313244",
      fg_color = "#f5e0dc",
    },
  }

  config.color_scheme = "Catppuccin Mocha"
  config.colors = { tab_bar = tab_bar_colors }

  config.font = wezterm.font_with_fallback(fonts)
  config.font_size = 24
  config.command_palette_font_size = 20
  config.window_frame = {
    font = wezterm.font_with_fallback(fonts),
    font_size = 16,
  }

  config.initial_cols = 150
  config.initial_rows = 42
  config.window_background_opacity = 0.92
  config.macos_window_background_blur = 28
  config.window_decorations = "TITLE | RESIZE"
  config.window_padding = window_padding

  config.hide_tab_bar_if_only_one_tab = false
  config.use_fancy_tab_bar = false
  config.show_new_tab_button_in_tab_bar = false
  config.tab_max_width = 32
end

return M
