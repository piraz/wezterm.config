local wezterm = require("wezterm")
local color = require("config.color")
local env_os = require("env.os")

local font_size = 10
if env_os.is_mac() then
    font_size = 10
end

return {
    font = wezterm.font "JetBrains Mono NL",
    font_size = font_size,
    color_scheme = color.schemes.solar_flare_base16,
    window_background_opacity = 0.94,
}

