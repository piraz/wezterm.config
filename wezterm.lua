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

local font_size = 15
if env_os.is_mac() then
    font_size = 20
end

local config = {
    audible_bell = "Disabled",
    enable_scroll_bar = true,
    font = wezterm.font "JetBrains Mono",
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    font_size = font_size,
    front_end = front_end,
    color_scheme = color.schemes.solar_flare_base16,
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.90,
    scrollback_lines = 7000,
    keys = {
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
    },
    window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 0,
    },
}

-- See: https://github.com/HeyItsGilbert/dotfiles/blob/main/.wezterm.lua
if env_os.is_windows() then
    config.default_prog = { 'pwsh.exe', '-NoLogo' }
    config.color_scheme = color.schemes.andromeda
end

return config
