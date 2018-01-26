-- 模块与包
dofile("./libl.lua")
--loadfile("./libl.lua")
--定义模块名
-- module 函数
module = {}
-- 继承访问全局变量
-- setmetatable(module, {__index = _G})
-- module(..., package.seeall)

module.constant = "常量"

function module.func1()
    io.write("这个一个共有函数\n")
end

local function func2()
    print("这个是一个私有函数")
end

function module.func3()
    func2()
end

-- return module 等同于
package.loaded[module] = module












