
-- 1、这是注释
--[[
    lua 学习
--]]

-- 加载程序库
dofile("libl.lua");

a=1;
b=a*2
print(b)

num = norm(2,3);
print(twice(num))


-- 三横是重新启用注释里面的内容
---[[
print(twice(5));
--]]
--[[
print(type("Hello world"))      --> string
print(type(10.4*3))             --> number
print(type(print))              --> function
print(type(type))               --> function
print(type(true))               --> boolean
print(type(nil))                --> nil
print(type(type(X)))            --> string

--]]

x="dasdsad"
print(type(true))
print(type(print))


print("-----------------------------------------------");
--[[


书写数字常量上可以用科学计数发
print(4.47e-3);
print(0.3e12);
print(5e+20);
--]]

-- 2、字符串替换
a2 = "one string";
b2 = string.gsub(a2, "one", "another");
print(b2);

--[[
    1、字符串由一对双引号或单引号来表示。
    2、也可以用 2 个方括号[] --来表示一块字符串。
    3、字符串连接使用的是 ..  连接
--]]
page = [[
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>

</body>
</html>
]]

print("-------- print 数字的操作  加减乘除   -------")
print("3" + 2);
print("3" + "2");
print("3" * "2");

-- print(page)

str1 = [===[
-------- string------
]===]

print(str1);

print("------ 对于 table  的操作 --------");  
--[[
    3、对于 table  的操作
    1.Lua 中的表（table）其实是一个"关联数组"（associative arrays），数组的索引可以是数字或者是字符串
    2.在 Lua 里表的默认初始索引一般以 1 开始
    3.可以用 分号 ; 代替逗号 ,
--]]
-- 创建一个空的tab 和初始化一个 table 
local table = {"apple", "pear", "orange", "grape",
{a=1,b=2},
{c=1,d=2},
{e=111,f=2},
}
table['key'] = "value"
key = 10;
table[key] = "22"
table[key] = table[key] + 11

print(table[7].e);
dd(table);

print("-----允许使用特殊运算符的方式------");
opnames = {['+'] = 'add', ['-']='del', ['*']='mul', ['/'] = 'div'}


-- 循环输出的时候， 索引情况下：没有的值的时候输出nil
for i=1,10 do
   -- print(table[i]);
end

print(#table .."---位数");

print("------ next -------");
c = {'c1','c2','c3'};
b21 = {c1="b31", c2="b32"}
a21 = b21[c[1]];
print(a21);


tab1 = { key1 = "val1", key2 = "val2", "val3" }

for k, v in pairs(tab1) do
    print(k .. " - " .. v)
end

print("-------变量 = nil 的上 等于删除--------------");
tab1.key1 = nil; -- 直接赋值为空
for k, v in pairs(tab1) do
    print (k .."---".. v);
end

print("-------字符串类型转换 # 获取字符串长度---------");
--[[
    1.转化为数字 tonumber
    2.转化为字符串 tosting
    3.用#号获取字符串的长度 
--]]
line = io.read()
n = tonumber(line);
--print(n)
print(#"hello")


print("---------对于if的使用---------")

if true or nil then
    print("---not false--or-- nil ---");
else

    print("-----false---or-- nil ---");
end


print("-----------表达式------------");
--[[
    类型不一致的变量不能比较
-- 取余规则 a%b == a-floor(a/b)*b
   1.不等于：~=  
   ----  逻辑运算符 and or not  所有逻辑运算符都把false和nil 视为假
   x = x or v 等同于 if not x then x=v end 
   (a and b ) or c  等同于 三元运算: max = (a > b ) and x or y
   not  只返回 true 和 flase 　
 
--]]
-- 圆周率
x=math.pi;
print(x - x%0.01);


print("--------赋值---------");

--[[
    5、赋值
    1.lua 允许多重副赋值
        
--]]
-- 当c5为空的时候 输出值为nil 
-- 当多出d5的时候 它将被丢弃
a5, b5, c5 = 'a5', 'b5', 'c5', 'd5'
print(a5, b5, c5);
-- 交换
x5, y5 = y , x
ar5 = {i="1", j="2"}
ar5['i'], ar5['j'] = ar5['j'], ar5['i']

print(ar5['i'])

print("--------变量---------")
--[[
    6、变量
    1. j = 10  --全局变量
    2. local j =10  -- 局部变量

--]]
do
    j6 = 10  --全局变量
    local y6 = 1  -- 局部变量

    while y6 < j6 do
        local j6 = y6 * 2
        print(j6)
        y6= y6+1
    end

    if y6 > 20 then
        local j6
        y6 =20
        print(y6+2)
    else
        print(j6);
    end
    print("--y6 = ".. y6)
end

-- 打印全局变量
print(z);

do -- 域
a6, b6 = 2, 10
if ( a6 < b6) then
    print(a6)
    local a6
    print(a6)
end 
print(a6, b6)
end

foo = "我是全局foo";
local  foo = foo .."加了局部" -- 把全局赋值给局部
print(foo)


--[[
    7、结构控制
    1. if then  else -> (elseif)  end 
    2. while do break; end 
    3. repeat until 重复执行循环，直到 指定的条件为真时为止
    4. for do end 一般类型  for i=10,1,-1 do
                               print(i)
                               break;
                            end
    5. 泛型for循环  for i,v in ipairs(a)  迭代类似js遍历
                       do print(v) 
                       break;
                    end  
    
--]]

repeat 
    line = io.read()
until line ~= "";
print(line);






