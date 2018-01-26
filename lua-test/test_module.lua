-- 引入模块与包
dofile("libl.lua");
-- m= require("module");

-- -- 别名加载
-- print(m.constant)
-- -- 正常加载
-- module.func1()
-- 设置环变量, 系统默认路径：LUA_PATH

-- export LUA_PATH="~/lua/?.lua;;"
-- print(LUA_PATH);

-- 加载lua socket 库
-- local socket = require("socket")
-- print(socket._VERSION)

-- 或者 local path = "/usr/local/lua/lib/libluasocket.so"
-- local path = "C:\\windows\\luasocket.dll"，这是 Window 平台下
-- local f = assert(package.loadlib(path, "luaopen_socket"))


-- 搜索最大最小值
function mixandmax( ... )
    local mi = 1;
    local m = (...)[mi] 
    local xi = 1
    local x = (...)[xi]
    for i,v in pairs(...) do

        if v > m then
            mi = i; m = v
        end

        if v < x then 
            xi=i; x = v 
        end
    end
    return "位置:"..mi.."值:"..m , "位置:"..xi.."值:"..x 
end


print(mixandmax({8,2,6,23,4,56,87,1,3}))

-- 关于unpack 类似于递归 依次输出table 数据
function unpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], unpack(t, i+1)
    end
end

print(unpack({9,2,3,5,6},1))

-- 函数深入
-- a = { p = print}
-- a.p("hello world");
-- -- 引用正玄函数
-- print = math.sin
-- a.p(print(1));
-- sin = a.p
-- sin(10,20)

-- 匿名函数
fuo = function (x)
    return 2*x
end

print(fuo(2))

-- table 操作
network = {
    {name='grauna', ip="1"},
    {name='lua', ip="2"},
    {name='box', ip="3"},
    {name='zhang', ip="4"},
    {name='lisi', ip="5"}
}
--  table.sort (table [, comp])
table.sort( network, function (a,b)
return (a.name > b.name)
end)

fruits = {"banana","orange","apple"}
-- 返回 table 连接后的字符串
--  table.concat (table [, sep [, start [, end]]]):
print("连接后的字符串:",table.concat(fruits ,',', 2, 3))
-- 插入
-- table.insert (table, [pos,] value):
table.insert(fruits,"mango")
table.insert(fruits, 2,"grapes") -- 索引为 2 的元素为 
-- dd(fruits)
-- 移除
-- table.remove (table [, pos]) 
table.remove(fruits, 3) -- 移除之后重新创建索引
dd(fruits)

--  table.maxn (table) Lua5.2 之后弃用
function table_maxn(t)
  local mn=nil;
  for k, v in pairs(t) do
    if(mn==nil) then
      mn=v
    end
    if mn < v then
      mn = v
    end
  end
  return mn
end
tbl = {[1] = 2, [2] = 6, [3] = 34, [26] =5}
print("tbl 最大值：", table_maxn(tbl))
print("tbl 长度 ", #tbl)
-- 获取table 长度
function table_leng(t)
  local leng=0
  for k, v in pairs(t) do
    leng=leng+1
  end
  return leng;
end


do 
--  原型：io.open (filename [, mode])  
--[[
解释：这个函数会以参数mode所描述的方式代开文件
filename并返回一个文件描述符，如果出错将会返回nil并且附带一个错误信息。不同的mode含义解释如下：
"r":以只读方式打开文件，该文件必须存在，否则返回nil。（默认的打开方式）
"w":以只写方式打开文件，若文件存在则清空文件内容，若文件不存在则建立该文件，从头开始写入。
"a":以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。
"r+":以读写方式打开文件，该文件必须存在，读取时从文件头开始读，写入时从文件头开始写，保留原文件中没有被覆盖的内容；
"w+":以读写方式打开文件，若文件存在则清空文件内容。若文件不存在则建立该文件，从头开始写入，读取文件时从头读取。
"a+":以附加方式打开可读写的文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾后，即文件原先的内容会被保留。
--]]    
    local oldeopn = io.open 
    local access_ok = function(filename, mode)
         print('检查文件是：', filename, mode)
         return true     
    end
    io.open = function (filename, mode)
        if access_ok(filename, mode) then
               return oldeopn(filename,mode);  
        else
               return nil , "access denied"
        end
    end
     print(io.open('D:/phpStudy/WWW/test/text.lua','r'))
end


-- 非全局函数
lib = {
    foo = function (x,y) return x + y end,
    goo = function (x,y) return x - y end
}

local fact
fact = function (n)
    if n == 0 then
        return 1
    else
         return n * fact(n - 1)
    end
end
print(fact(5));

-- 泛型 for 和 while
function values(t)
    local i = 0
    return function () i = i +1 return t[i] end, i
end
local t = {10, 20 ,30}

iter = values(t)
while iter do 
    local element, k = iter()
    if element == nil then
        break
    end
    print(element, k)
end

for k, element in values(t) do
    print(k,element)
end
file = io.open("./libl.lua", "r")
-- 复杂性 迭代器
function allwords()
    local line = io.read()
    local pos = 1
    return function ()
        while line do 
            local s, e = string.find(line, "%w+", pos)
            if s then
                pos = e + 1
                return string.sub(line, s, e)
            else
                line = io.read()
                pos = 1
            end
        end
        return nil
    end
end

-- for word in allwords do
--     print(word)
-- end

print(io.read("*n"))


-- loadstring 执行外部代码
i = 0 
f = loadstring("i = i + 1; print(i)")
f()
f()
print(f());

-- 错误处理
-- print("enter a number")
-- n = assert(io.read("*number"), "报错了")

-- print(n)
-- local function add(a,b)
--    assert(type(a) == "number", "a 不是一个数字")
--    assert(type(b) == "number", "b 不是一个数字")
--    return a+b
-- end
-- add(10)





-- 引入模块
require("module")


local modname = module
local M = {}
_G[modname] = M
package.loaded[modname] = M
-- setmetatable(M, {__index = _G})  继承全局变量
-- local _G = _G -- 声明一个局部变量保存全局变量
--导入段 声明这个模块从外界所需要的东西
local sqrt = math.sqrt
local  io = io
setfenv(1, M)

function add(c1, c2)
    return new(cl.r + c2 + r, cl.i + c2.i)
end



























