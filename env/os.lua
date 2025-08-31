local wezterm = require("wezterm")

local M = {}

function M.is_linux()
    return string.find(wezterm.target_triple, "linux")
end

function M.is_mac()
    return string.find(wezterm.target_triple, "darwin")
end

function M.is_windows()
    return string.find(wezterm.target_triple, "windows")
end

return M
