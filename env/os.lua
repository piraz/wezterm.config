-- Inspired by: https://bit.ly/3Y7sE3v

local M = {}


function M._clean_names(raw_os_name, raw_os_arch)
    raw_os_name = (raw_os_name):lower()
    raw_os_arch = (raw_os_arch):lower()

    local os_name, arch_name = "unknown", "unknown"

    -- print( ("Debug: %q %q"):format( raw_os_name, raw_arch_name) )

    local os_patterns = {
        ["windows"] = "Windows",
        ["linux"] = "Linux",
        ["osx"] = "Darwin",
        ["mac"] = "Darwin",
        ["darwin"] = "Darwin",
        ["^mingw"] = "Windows",
        ["^cygwin"] = "Windows",
        ["bsd$"] = "BSD",
        ["sunos"] = "Solaris",
    }

    local arch_patterns = {
        ["^x86$"] = "x86",
        ["i[%d]86"] = "x86",
        ["amd64"] = "x86_64",
        ["x86_64"] = "x86_64",
        ["x64"] = "x86_64",
        ["power macintosh"] = "powerpc",
        ["^arm"] = "arm",
        ["^mips"] = "mips",
        ["i86pc"] = "x86",
    }

    for pattern, name in pairs(os_patterns) do
        if raw_os_name:match(pattern) then
            os_name = name
            break
        end
    end
    for pattern, name in pairs(arch_patterns) do
        if raw_os_arch:match(pattern) then
            arch_name = name
            break
        end
    end
    return os_name, arch_name

end

function M.get_name()
    local os_name, os_arch = "Linux", "x86_64"

    if jit and jit.os and jit.arch then
        return M._clean_names(jit.os, jit.arch)
    end

    -- This is for windows
    if package.config:sub(1, 1) == "\\" then
        local env_os_name, env_os_arch =
            os.getenv("OS"), os.getenv("PROCESSOR_ARCHITECTURE")
        if env_os_name and env_os_arch then
            os_name = env_os_name
            os_arch = env_os_arch
        end
        return M._clean_names(os_name, os_arch)
    end

    os_name = io.popen("uname -s", "r"):read("*l")
    os_arch = io.popen("uname -m", "r"):read("*l")

    return M._clean_names(os_name:lower(), os_arch:lower())
end

function M.is_mac()
    local os_name = M.get_name()
    return os_name == "Darwin"
end

return M
