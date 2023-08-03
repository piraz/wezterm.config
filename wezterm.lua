local wezterm = require("wezterm")
local act = wezterm.action
local color = require("config.color")
local env_os = require("env.os")

local font_size = 14
if env_os.is_mac() then
    font_size = 19
end

return {
    audible_bell = "Disabled",
    font = wezterm.font "JetBrains Mono NL",
    font_size = font_size,
    color_scheme = color.schemes.solar_flare_base16,
    window_background_opacity = 0.90,
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
    },
}
