-- 调试 debug
dofile("libl.lua")
--[[

--]]
function tracback()
    for level = 1, math.huge do
        local info = debug.getinfo(level, "S1")
        if not info then break end
        if info.what == "C" then
            print(level, "C function")
        else
            print(string.format("[%s]:%d", info.short_src, info.currentline))
        end
    end
end

--print(debug.traceback())
-- 返回对象的环境变量。
print(getfenv(object))

-- 访问局部变量
function foo (a, b)
    local x
    do local c = a - b end
    local a = 1
    while true do
        local name, value = debug.getlocal(1, a)
        if not name then break end
        print(name, value)
        a = a +1
    end
end

-- foo(10, 20)

-- 钩子
function trace(event, line)
    local s = debug.getinfo(2).short_src
    print(s,line)
end
debug.sethook(trace, 1)

-- 性能剖析
local Counters = {}
local names = {}
local function hook ()
    local f = debug.getinfo(2,"f").func
    print(f)
    if Counters[f] == nil then
        Counters[f] = 1
        names[f] = debug.getinfo(2,"Sn")
    else
        Counters[f] = Counters[f] + 1
    end
end

local f = assert(loadfile(arg[1]))
debug.sethook(hook, "c")
debug.sethook()

function getname(func)
    local n = names[func]
    if n == "C" then
        return n.name
    end
    local lc = string.format("[%s]:%s", n.short_src, n.linedefined)
    if n.namewhat ~= "" then
        return string.format("%s(%s)", lc,n.name)
    else
        return lc
    end
end

for func, count in pairs(Counters) do
    print(getname(func), count)
end




















