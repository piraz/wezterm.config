-- Inspired by: https://bit.ly/3Y7sE3v
local wezterm = require("wezterm")

local M = {}

function M.is_linux()
    if string.find(wezterm.target_triple, "linux") then
        return true
    end
    return false
end

function M.is_mac()
    if string.find(wezterm.target_triple, "darwin") then
        return true
    end
    return false
end

function M.is_windows()
    if string.find(wezterm.target_triple, "windows") then
        return true
    end
    return false
end

return M
