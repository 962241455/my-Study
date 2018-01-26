-- lua 的oop (面向对象)
--[[
面向对象特征
1） 封装：指能够把一个实体的信息、功能、响应都装入一个单独的对象中的特性。
2） 继承：继承的方法允许在不改动原程序的基础上对其进行扩充，这样使得原功能得以保存，而新功能也得以扩展。这有利于减少重复编码，提高软件的开发效率。
3） 多态：同一操作作用于不同的对象，可以有不同的解释，产生不同的执行结果。在运行时，可以通过指向基类的指针，来调用实现派生类中的方法。
4）抽象：抽象(Abstraction)是简化复杂的现实问题的途径，它可以为具体问题找到最恰当的类定义，并且可以在最恰当的继承级别解释问题。
--]]
dofile("libl.lua")

-- 定一个类(1)
local Account = {balance = 0}

function Account:withdraw(v)
    if v > self.balance then error "insufficient funds" end
    self.balance = self.balance - v
end
-- al = Account; Account = nil
-- al.withdraw(al, 100)

-- 定一个类(2)
-- Account = {balance =0 , withdraw = function ( self, v)
--     self.balance = self.balance - v
-- end}

function Account:deposit(v)
     self.balance = self.balance + v
end

-- -- 两种方式调用
-- Account.deposit(Account, 100)
-- Account:withdraw(50)


-- 类
function Account:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o 
end

local a = Account:new{balance=30}
a:deposit(100)
a:withdraw(120)
-- dd(a)

-- 继承
SpecidlAccount = Account:new()

-- 重写继承类
function SpecidlAccount:withdraw (v)
    if v >= self:getLimit() then
        error "insufficient funds getLimit"
    end
    self.balance = self.balance - v
end

-- 增加继承新类 
function SpecidlAccount:getLimit()
    return self.limit or 0 
end



s = SpecidlAccount:new{limit = 1000, balance = 500}
s:withdraw(110)
-- 直接修改类对象
function s:getLimit()
    self.balance = self.balance * 0.10
    return self.balance
end
s:getLimit()
-- dd(s)

-- 多重继承

-- 在table 中查找k
local function search(k, plist)
    for i=1, #plist do
        local v = plist[i][k]  -- 查找第 i 个基类
    if v then return v end
    end
end

function createClass( ... )
    local c = {} -- 新类
    local parents = {...}
    -- 类在父类列表中搜索方法
    setmetatable(c, {__index = function ( t, k )
        local v = search(k, parents)
        t[k] = v --保存输入的值
        return v
    end})

    --将c 作为其实列元素
    c.__index = c 
    -- 为这个新类定义一个构造函数
    function c:new(o)
        o = o or {}
        setmetatable(o, c)
        return o
    end

    return c -- 返回一个新类
end

Namad = {}
-- 获取
function Namad:getname()
    return self.name
end
-- 修改
function Namad:setname(n)
    self.name = n
end
NameAccount = createClass(Account, Namad)
local userName = NameAccount:new{name= "lisi"}
print(userName:getname())

-- 类的 -> 接口
function newAccount(initialbalance)
    local self = {
        balance = initialbalance,
        limit = 1000.00
    }

    local withdraw = function (v)
        self.balance = self.balance - v
    end
    local depoist = function ( v )
        self.balance = self.balance + v
    end

-- 任何一个用户都不能访问
    local extra = function (  )
        if self.balance > self.limit then
            return self.balance * 0.1
        else
            return 0
        end
    end

    local getBalance = function ( )
        local num = self.balance + extra() 
        return num
    end

    return {
        withdraw = withdraw,
        depoist = depoist,
        getBalance = getBalance
    }
end

accl = newAccount(10000)
accl.withdraw(40)
print(accl.getBalance())

-- 单一方法

function newObject( value )
    return function ( action , v)
        if action == "get" then return value
        elseif action == "set" then value = v
        else
            error "not action"
        end
    end
end

local d = newObject(0)
print(d("get"))
d("set", 20)
print(d("get"))

--  弱引用table  = 垃圾回收

print("-----------垃圾回收-------------")
local la = {}
local ji = {__mode = "k"}
setmetatable(la, ji)
key = {}
la[key] = 1 --弱引用table只会回收对象不会回收数字和字符串
la[key] = 2
collectgarbage()-- 强制进行一次垃圾处理

for k,v in pairs(la) do
    print(k,v)
end


-- 备忘录  用时间换空间  的编程技术
local results = {}
setmetatable(results, {__mode = "v"})
function mem_loadstring(s)
    local res = results[s]
    if res then 
        res = assert(loadstring(s))
        results[s] = res
    end
    return res
end

local metas = {}
setmetatable(metas, {__mode = "v"})
function setDefault_s(t, d)
    local mt = metas[d]
    if mt == nil then
        mt = {__index = function () return d end}
        metas[d] = mt
    end
    setmetatable(t, mt)
end
-- 对象属性











