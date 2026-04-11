local wezterm = require("wezterm")
local config = wezterm.config_builder()

local config_root = wezterm.home_dir .. "/dotfiles/wezterm"

local function load_module(name)
	return dofile(config_root .. "/config/" .. name .. ".lua")
end

load_module("appearance").apply(config, wezterm)
load_module("behavior").apply(config)
load_module("launch").apply(config, wezterm)
load_module("keys").apply(config, wezterm)
load_module("status").setup(wezterm)

return config
