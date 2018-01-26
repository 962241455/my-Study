
dofile("libl.lua")
-- 跟踪访问table 
tm = {}
-- 创建元表
local _tm = tm
local tm = {}
local index = {}
local tm2 = {
    __index = function (t, k)
        print("assert to element ", tostring(k))
        return _tm[k] -- 返回原值
    end,
    __newindex = function (t, k, v)
        print("update fo element ->k：" .. tostring(k) ," to： " ..tostring(v))
        _tm[k] = v -- 更新原来的值
    end
}
setmetatable(tm, tm2)

tm[1] = "dadadad"
print(tm[1])

-- 环境 environment lua 的所有全局变量是放在一个常规的table中  定义为：_G
print("------环境 environment ----")
for n in pairs(_G) do
    --print(n)
end

--value = loadstring("return" .. varname)() varname:需要查找的环境
value = _G[varname] -- 简单的获取全局变量
-- print(value)

-- 复杂的获取值
function getField( f )
    local v = _G
    -- string.gmatch ：迭代器函数，每一次调用这个函数，返回一个在字符串 str 找到的下一个符合 pattern 描述的子串
    for w in string.gmatch(f, "[%w_]+") do
        v = v[w]
    end
    return v
end

-- 多层级赋值
function setField( f, e)
    local v = _G
    -- string.gmatch ：迭代器函数，每一次调用这个函数，返回一个在字符串 str 找到的下一个符合 pattern 描述的子串
    for w, d in string.gmatch(f, "([%w_]+)(%.?)") do
        if d == "." then
            v[w] = v[w] or {}
            v = v[w]
        else
            v[w] = e
        end
    end
    return v
end

setField("a.b.c.d", 10)
print(getField("a.b.c.d"))

-- 全局变量的声明
-- _G talbe 中不存在的key 发生错误
-- setmetatable(_G, {
--     __newindex = function (_, n)
--         error("attempt to write to undeckared variable" .. n, 2)
--     end,
--     __index = function (_, n)
--         error("attempt to read undeckared variable" .. n, 2)
--     end
--     })

function declare(name, initval)
    rawset(_G, name, initval or false) -- 绕过元表
end


-- newindex = function (t, v, n)
--     local w = debug.getinfo(2，"S").what
--     if w ~= "mian" and w ~= "C" then
--         error("attempt to write undeckared variable"..n, 2)
--     end
--     rawset(t, n, v)
-- end

if rawget(_G, val) ==  nil then
    print(val, "没有")
end

-- 非全局变量
a= 1
-- setfenv(1, {g =_G}) -- 改变当前全局变量的 环境
-- g.print(g.a)

-- 环境继承
a = 1 
local  newgt = {}
setmetatable(newgt, {__index = _G})
setfenv(1, newgt)
newgt.print(a)

function factory()
    return function ()
        return b
    end
end
 -- 共享全局的 的函数 变量
b = 3
fl = factory()
f2 = factory()

print(fl())
print(f2())

-- for n in pairs(_G) do
--     print(n)
-- end

-- 模块与包
function require( name )
    if not package.loaded[name] then -- 检查模块是否已经加载
        local loader = findloader(name)
        if loader == nil then
            error("unable to load module" .. name)
        end
        package.loaded[name] = true --将模块标记为以加载
        local res = loader(name) -- 初始化模块
        if res ~= nil then
            package.loaded[name] = res
        end
    end
    return package.loaded[name]
end

print("-------- table.inset -------")
local tabs = {}
for line in io.lines('./iotest.txt') do
    -- table 增加
    table.insert(tabs, line)
end

-- table 删除
table.remove(tabs,2)
local sort = {
    lua_set = 10,
    lua_get = 20,
    lua_del = 30
}
-- table 排序
table.sort(sort)

-- 排序迭代器
function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
        a[#a + 1] = n
    end
    table.sort(a, f)
    local i = 0
    return function()
        i = i + 1
        return a[i], t[a[i]]
    end
end
-- local rt, rk = pairsByKeys(tabs, function(a,b)return (tonumber(a) <  tonumber(b)) end)
--另外一种基于foreach的调用方式(泛型for)
for name, val in pairsByKeys(sort, function (a,b) return (a > b) end) do
    print(name, val)
end


-- table 连接

function rconact(l)
    if type(l) ~="table" then   error ("this is not table:".. type(l)) end
    local res = {}
    for i = 1, #l do
        res[i] = rconact(l[i])
    end
    return table.concat(res, '\n') .."\n"
end
print(rconact(tabs))

print("------案例------")
skillgroup =
{
    ["101"] =
    {
        SkillGroupID = 101,
        SkillType = 0,
        Condition = 1,

    },
    ["102"] =
    {
        SkillGroupID = 102,
        SkillType = 1,
        Condition = 1,

    },
    ["103"] =
    {
        SkillGroupID = 103,
        SkillType = 1,
        Condition = 1,

    },
    ["104"] =
    {
        SkillGroupID = 104,
        SkillType = 1,
        Condition = 2,

    },
}

for i in pairs(skillgroup) do
    print("直接输出:"..i)
end
-- 直接获取table的数据进行遍历发现数据不像list那样是直接索引取出排序好的，下面进行排序
-- 插入key
local keyTest ={}
for i in pairs(skillgroup) do
    table.insert(keyTest,i)
end
-- 对key进行升序
table.sort(keyTest,function(a,b)return (tonumber(a) <  tonumber(b)) end)
--对key进行降序
table.sort(keyTest,function(a,b)return (tonumber(a) >  tonumber(b)) end)
-- 结果数据
local result = { }
for i,v in pairs(keyTest) do
    table.insert(result,skillgroup[v])
   -- print("id:"..v.."     data:"..skillgroup[v].SkillGroupID)
end

























