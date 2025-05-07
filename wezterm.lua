local conf_file = os.getenv("WEZTERM_CONFIG_FILE")
local front_end = os.getenv("WEZTERM_FRONT_END") or "WebGpu"

if conf_file then
    local dir_sep = "/"
    local var_sep = ":"
    if conf_file:match("(.*:\\)") then
        dir_sep = "\\"
        var_sep = ";"
    end
    local conf_path = conf_file:match("(.*" .. dir_sep .. ")")
    package.path = package.path .. var_sep .. conf_path .. "?" .. dir_sep ..
        "init.lua"
    package.path = package.path .. var_sep .. conf_path .. "?.lua" .. var_sep
end

local wezterm = require("wezterm")
local act = wezterm.action
local color = require("config.color")
local env_os = require("env.os")

local font_size = 16
if env_os.is_mac() then
    font_size = 20
end

local config = wezterm.config_builder()

config.audible_bell = "Disabled"
config.enable_scroll_bar = false
config.font = wezterm.font "JetBrains Mono"
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.font_size = font_size
config.front_end = front_end
config.color_scheme = color.schemes.abernathy
-- config.color_scheme = color.schemes.solar_flare_base16
config.hide_tab_bar_if_only_one_tab = true
if not env_os.is_mac() then
    config.window_decorations = "NONE"
end
config.window_background_opacity = 0.90
config.scrollback_lines = 7000
config.keys = {
    { key = "1", mods = "ALT", action = act.ActivateTab(0) },
    { key = "2", mods = "ALT", action = act.ActivateTab(1) },
    { key = "3", mods = "ALT", action = act.ActivateTab(2) },
    { key = "4", mods = "ALT", action = act.ActivateTab(3) },
    { key = "5", mods = "ALT", action = act.ActivateTab(4) },
    { key = "6", mods = "ALT", action = act.ActivateTab(5) },
    { key = "7", mods = "ALT", action = act.ActivateTab(6) },
    { key = "8", mods = "ALT", action = act.ActivateTab(7) },
    { key = "9", mods = "ALT", action = act.ActivateTab(8) },
    { key = "0", mods = "ALT", action = act.ActivateTab(9) },

    -- Compare this with the older syntax shown in the section below
    { key = "[", mods = "ALT", action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "ALT", action = act.ActivateTabRelative(1) },
    { key = "{", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
    { key = "}", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },

    { key = "n", mods = "SHIFT|ALT", action = act.ToggleFullScreen },
}
config.window_frame = {
    border_left_width = '0cell',
    border_right_width = '0cell',
    border_bottom_height = '0cell',
    border_top_height = '0cell',
}
config.window_padding = {
    left = 5,
    right = 4,
    top = 3,
    bottom = 0,
}

-- See: https://github.com/HeyItsGilbert/dotfiles/blob/main/.wezterm.lua
if env_os.is_windows() then
    config.default_prog = { 'pwsh.exe', '-NoLogo' }
    config.color_scheme = color.schemes.andromeda
end

return config
