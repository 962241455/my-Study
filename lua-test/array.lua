
dofile("libl.lua")
-- 使用索引创建一个数组
arr = {}
for i=-5,5 do
   arr[i] = 0
end

-- dd(arr)
-- print("length",#arr)

-- 矩阵 与多维数组
mt = {}
maxRows = 3
maxColumns = 3
for i=1, maxRows do
    -- mt[i] = {}
    for j= 1, maxColumns  do
        -- mt[i][j] = i*j
       mt[(i-1) * maxColumns + j ] = i*j
    end
end

-- dd(mt)

-- 链表
local list = {next = list, value = v}
local l = list
while l do 
    l = l.next
end

-- 队列 和双向队列

local tab = {}
function tab.new()
    return {first = 0, last = -1}
end

-- 在表的两端插入和删除元素
function tab.pushfirst(list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end

function tab.pushlast(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function popfirst(list)
    local first = list.first
    if first > list.last then error("没有更多值") end
    local value = list[first]
    list[first] = nil 
    list.first = first + 1
    return value
end

function poplast(list)
    local last = list.last
    if last > list.first then error("没有更多值") end
    local value = list[last]
    list[last] = nil 
    list.last = last - 1
    return value
end

----  集合与无序组-----
local  reserved = {
    ["while"] = true,
    ["end"] = true,
    ["function"] = true,
    ["local"] =true
}

for w in allwords() do
    print(w)
end

function set(list)
    local set = {}
    for k, l in ipairs(list) do
        set[l] = true
    end
    return set
end

reserveds = set{"while", "end", "function", "print"}

-- dd(reserveds)

-- 递增计数器 
function insert(bag, element)
    bag[element] = (bag[element] or 0 ) + 1
end

-- 递减计数器
function remvoe(bag, element)
    local  count = bag[element]
    bag[element] = (count and count > 1) and count -1 or nil
end


----- 字符串缓冲 ------

-- 在lua中，读取文件的时候，我们以一个tab 作为字符串缓冲
local  buff = {}

for line in io.lines() do
    buff[#buff + 1] = line
end
-- table.concat 函数列出参数中指定table的数组部分从
local s = table.concat(buff, "\n") .."\n" -- 最后一个换行 是在concat 执行完成之后最近添加一个


function addStribng(stack , s)
    stack[#stack + 1] = s -- 将数据s  压缩在 stack栈 里面
    for i= #stack -1, 1 , -1 do
        if #stack > #stack[i+1] then
            break
        end
        stack[i] = stack[i] .. stack[i + 1]
        stack[i + 1] = nil
    end
    dd(stacks)
end
stacks = {}
s = 's'
addStribng(stacks, s)



-- 图

function findpath(curr, to, path, visited)
    path = path or {}
    visited = visited or {}
    if visited[curr] then
        return nil
    end
    visited[curr] = true
    path[#path + 1] = curr
    if curr == to then
        return path
    end
    for node in pairs(curr.adj) do
        local p = findpath(node, to, path, visited)
        if p then return p end
    end
    path[#path] = nil
end




-- 数据文件与持久性


local  count = 0
-- function Entry( _ )
--     count = count + 1
-- end
-- dofile("date")
-- print("entry count", count)

local  authors = {}
function Entry( b )
    authors[b.author] = true
end

dofile("date")
dd(authors)

-- 数据串行化
print("-----------数据串行化---------")
-- 对于包含特殊字符的
str = "?/]"
io.write("[[" , str , "]]")

function serialize(o)
    local  strs = ""
    if type(o) == "number" then --对数字操作 
        strs = o
        return strs
       -- io.write(o)
    elseif type(o) == "string" then --对字符串操作
        strs =  string.format("%q", o)
        return strs
       -- io.write(string.format("%q", o))
    elseif type(o) == "table" then  -- 对表的的操作
        strs = strs .. "{\n"
        for k,v in pairs(o) do
            strs = strs .."[\"".. k .. "\"] ="
            strs = strs .. serialize(v)
            strs = strs .. ",\n"
        end
        strs = strs .. "}\n"
    else
        error("cannot serialize a ".. type(o))
    end
    return strs
end
-- 字符串之间的大小转换
print("\n")
string1 = "Lua";
print(string.upper(string1))
print(string.lower(string1))

-- 保存无环的table
local serStr= serialize{a="12", b="lua", key ="dsada\dadssa"}
print(serStr)

--  保存有环的table
function baseSerialine(o)
    if type(o) == "number" then --对数字操作 
        return tostring(o)
    elseif type(o) == "string" then --对字符串操作
        return string.format("%q", o)
   end
end

function save(name, value, saved)
    local saved = saved or {}
    io.write (name, " = ")
    if type(value) == "number" or type(value) == "string" then
        io.write(baseSerialine(value), "\n")
    elseif type(value) == "table" then
        if saved[value] then  -- 判断是否保存过
            io.weite(saved[value], "\n")
        else
            saved[value] = name
            io.write("{}\n")
            for k,v in pairs(value) do
                k = baseSerialine(k)
                local fname = string.format("%s[%s]", name, k) -- k 和 name 值的转化
                save(fname, v, saved)
            end
        end
    else
        error("cannot save a ".. type(value))
    end
 end 


local t = {}
save("a" ,{x=1, y=2, {3,4,5}}, t)
save("b" ,{x=6, y=7, {8,5}}, t)
dd(t)



--  元表 meatatable 元方法
print("------元表 meatatable------")
-- setmetatable(table,metatable): 对指定table设置元表(metatable)
-- getmetatable(table): 返回对象的元表(metatable)。
local mt = {}
local mt1  = {}
setmetatable(mt,mt1)
print(assert(getmetatable(mt) == mt1))

-- 算数类元方法
local Set = {}

-- 创建一个新的集合
function Set.new(l)
    local set = {}
    setmetatable(set, mt)
    for i,v in ipairs(l) do
        set[v]= true
    end
    return set
end

function Set.union(a, b)
    local res = Set.new{}
    for k in pairs(a) do  res[k] = true end
    for k in pairs(b) do  res[k] = true end
    return res
end

function Set.intersection(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

function Set.tostring(set) -- 修改输出行为
    local  l = {}
    for k in pairs(set) do
        l[#l + 1] = k
    end
    return "{" .. table.concat(l, ",") .. "}"
end

function Set.print(s)
    print(Set.tostring(s))
end

s1 = Set.new{10,20,30,50}
s2 = Set.new{1,2, 30}
--[[
__add   对应的运算符 '+'.
__sub   对应的运算符 '-'.
__mul   对应的运算符 '*'.
__div   对应的运算符 '/'.
__mod   对应的运算符 '%'.
__unm   对应的运算符 '-'.
__concat    对应的运算符 '..'.
__eq    对应的运算符 '=='.
__lt    对应的运算符 '<'.
__le    对应的运算符 '<='.
__call 元方法在 Lua 调用一个值时调用。以下实例演示了计算表中元素的和
__tostring 元方法用于修改表的输出行为
--]]
 mt.__add = Set.union -- 求合集
s3 = s1 + s2
Set.print(s3)

mt.__mul = Set.intersection -- 交集
Set.print((s1 + s2) * s1) -- 集合的交集

--  关系元方发
mt.__le = function (a, b) --集合闭包
    for k in pairs(a) do
        if not b[k] then return false end
    end
    return true
end

mt.__lt = function (a, b)
    return a <= b and not (b <= a)
end

mt.__eq = function (a, b) -- 集合相等性
    return a <= b and b <= a
end

s3 = Set.new{2, 4}
s4 = Set.new{4 , 10 , 2}

print(s3 <= s4)
print(s3 < s4)
print(s3 >= s4)
print(s3 > s4)
print(s3 == s4)


-- 库定义元方法
mt.__tostring = function(mytable) -- 修改输出行为
    sum = 0
    for k, v in pairs(mytable) do
        sum = sum + k
    end
    return "表所有元素的和为 " .. sum
  end

s5 = Set.new{ 10, 20, 30}
print(s5)

-- 保护元表
mt.__metatable = "now your business"

s6 = Set.new{}
print(getmetatable(s6))
-- assert(setmetatable(s6, {}))

-- table  访问元方法 __index则用来对表访问 
-- 当你通过键来访问 table 的时候，如果这个键没有值，
-- 那么Lua就会寻找该table的metatable（假定有metatable）中的__index 键。如果__index包含一个表格，Lua会在表格中查找相应的键

Window = {}
Window.protetype = {x =0 , y= 1, width = 100, height=200}
Window.mt ={}

--声明构造函数
function Window.new(o)
    setmetatable(o, Window.mt)
    return o 
end
Window.mt.__index = function (table, key)  -- 当查找lua 里面没有这个真的时候，默认调用__index 查询原型元表里面的内容 并且返回
    return Window.protetype[key]
end

-- Window.mt.__index = Window.protetype -- 简化写法

w = Window.new{x=10, y=20}
print(w.height)


-- __newindex 元方法用来对表更新

Window.mt.__newindex = Window.protetype
w1 = Window.new{a=2, b=3}
dd(w1)

-- 具有默认值的table
function setDefault(t, b)
    local  mt1 = {__index = function () return b end}
    setmetatable(t, mt1)
end

tabs = {x=10, y=20}
setDefault(tabs, 0)
print(tabs.x, tabs.z)

local mt2 = {__index = function (t) return t.___ end}

function setDefault1(t, d)
    t.___ = d 
    setmetatable(t, mt2)
end

local key = {}
local  mt2 = {__index = function ( t ) return t[key] end}
function setDefault2(t, d )
    t[key] = d
    setmetatable(t, mt2)
end

-- 跟踪访问table 
tm = {}
-- 创建元表
local _tm = tm
local tm = {}
local index = {}
local tm2 = {
    __index = function (t, k)
        print("assert to element ", tostring(k))
        return t[index][k] -- 返回原值
    end,
    __newindex = function (t, k, v)
        print("update fo element ->k：" .. tostring(k) ," to： " ..tostring(v))
        t[index][k] = v -- 更新原来的值
    end
}

function track(t)
    local proxy = {}
    proxy[index] = t
    setmetatable(proxy, tm2)
    return proxy
end


dd(track("dadadad"))

-- 只读的table

function readOnly(t)
    local  proxy = {}
    local mty = { -- 创建元表
        __index = t,
        __newindex = function (t, k, v )
            error("attempt to update a raed-only  table", 2)
        end
    }
    setmetatable(proxy, mty)
    return proxy
end

local days = readOnly{"sunday", "monday", "Tuesday", "Wedesday", "Thursday","Friday", "Saturday"}
print(days[1])
-- days[2] = "Noday"




