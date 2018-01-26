


function norm(a, b)
    return (a^2 + b^2) ^ 0.5
end

function twice(a)
    return 2*a    
end

function dd(data)
    for k,v in pairs(data) do
        if type(v) == "table" then
            dd(v);
        end
        if type(v) == "string" or type(v) == "number" or type(v) == "boolean" then
            print(k , v)
        end
    end    
end

function dg(v)
    print("-------G-------")
    for n in pairs(v or _G) do
        print(n)
    end
end


-- function 可以以匿名函数（anonymous function）的方式通过参数传递

function testFun(tab,fun)
    for k ,v in pairs(tab) do
        -- print(fun(k,v));
    end
end

tab={key1="val1",key2="val2"};
testFun(tab,
    function(key,val)--匿名函数
        return key.."="..val;
    end
)


-- 链表的使用
list = nil;
--for line in io.lines() do
--   list = {next=list, value=line}
--end
local l = list
while l do
    print(l.value)
    l= l.next
    end

-- 相同变量名 全局变量要放在局部之前 才能生效
z = "我的全局z";
local z = "我的局部z";


myprint = function(param)
--  print("这是打印函数 -   ##",param,"##")
end

function add(num1,num2,functionPrint)
   result = num1 + num2
   -- 调用传递的函数参数
   functionPrint(result)
end
myprint(10)
-- myprint 函数作为参数传递
add(2,5,myprint)


--- 可变参数
function average(...)
   result = 0
   local arg={...}
   for i,v in ipairs(arg) do
      result = result + v
   end
   -- print("总共传入 " .. #arg .. " 个数")
   return result/#arg
end

-- print("平均值为",average(10,5,3,4,5,6))

-- 加载lua socket 库
-- local path = "C:\\windows\\luasocket.dll"，-- 这是 Window 平台下
-- local f = assert(package.loadlib(path, "luaopen_socket"))

function allwords()
    local line = io.read() -- current line
    local pos = 1          -- current position in the line
    return function ()     -- iterator function
        while line do      -- repeat while there are lines
            local s, e = string.find(line,"%w+",pos)
            if s then      -- found a word ?
                pos = e + 1 -- next position is after this word
                return string.sub(line,s,e) -- return the word
            else
                line = io.read()  -- word not foud; try next line
                pos = 1           -- restart from first position
            end
        end
    return nil  -- no more lines: end of travelsal
    end
end


