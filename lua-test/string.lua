
dofile("libl.lua")
--- 字符串库
-- string.upper(argument): 字符串全部转为大写字母
-- string.lower(argument):字符串全部转为小写字母
-- string.reverse(arg) 字符串反转
-- string.char(arg) 和 string.byte(arg[,int]) char 将整型数字转成字符并连接， byte 转换字符为整数值
-- string.len(arg) 计算字符串长度。
-- string.rep(string, n) 返回字符串string的n个拷贝

--[[
    string.format(...) 返回一个类似printf的格式化字符串
    %c - 接受一个数字, 并将其转化为ASCII码表中对应的字符
    %d, %i - 接受一个数字并将其转化为有符号的整数格式
    %o - 接受一个数字并将其转化为八进制数格式
    %u - 接受一个数字并将其转化为无符号整数格式
    %x - 接受一个数字并将其转化为十六进制数格式, 使用小写字母
    %X - 接受一个数字并将其转化为十六进制数格式, 使用大写字母
    %e - 接受一个数字并将其转化为科学记数法格式, 使用小写字母e
    %E - 接受一个数字并将其转化为科学记数法格式, 使用大写字母E
    %f - 接受一个数字并将其转化为浮点数格式
    %g(%G) - 接受一个数字并将其转化为%e(%E, 对应%G)及%f中较短的一种格式
    %q - 接受一个字符串并将其转化为可安全被Lua编译器读入的格式
    %s - 接受一个字符串并按照给定的参数格式化该字符串
--]]

--[[
它用于模式匹配函数 string.find, string.gmatch, string.gsub, string.match
-- string.find (str, substr, [init, [end]\]) 在一个指定的目标字符串中搜索指定的内容(第三个参数为索引),返回其具体位置。不存在则返回 nil。
-- string.gsub(mainString,findString,replaceString,num)  在字符串中替换,mainString为要替换的字符串， findString 为被替换的字符，replaceString 要替换的字符，num 替换次数
-- string.gmatch(str, pattern) 返回一个迭代器函数，每一次调用这个函数，返回一个在字符串 str 找到的下一个符合 pattern 描述的子串
-- string.match(str, pattern, init)
-- 只寻找源字串str中的第一个配对. 参数init可选, 指定搜寻过程的起点, 默认为1。在成功配对时, 函数将返回配对表达式中的所有捕获结果; 如果没有设置捕获标记, 则返回整个配对字符串. 当没有成功的配对时, 返回nil。

    .(点): 与任何字符配对
    %a: 与任何字母配对
    %c: 与任何控制符配对(例如\n)
    %d: 与任何数字配对
    %l: 与任何小写字母配对
    %p: 与任何标点(punctuation)配对
    %s: 与空白字符配对
    %u: 与任何大写字母配对
    %w: 与任何字母/数字配对
    %x: 与任何十六进制数配对
    %z: 与任何代表0的字符配对
    %x(此处x是非字母非数字字符): 与字符x配对. 主要用来处理表达式中有功能的字符(^$()%.[]*+-?)的配对问题, 例如%%与%配对
    [数个字符类]: 与任何[]中包含的字符类配对. 例如[%w_]与任何字母/数字, 或下划线符号(_)配对
    [^数个字符类]: 与任何不包含在[]中的字符类配对. 例如[^%s]与任何非空白字符配对
    '%' 用作特殊字符的转义字符，因此 '%.' 匹配点；'%%' 匹配字符 '%'
    单个字符类跟一个 '*'， 将匹配零或多个该类的字符。 这个条目总是匹配尽可能长的串；
    单个字符类跟一个 '+'， 将匹配一或更多个该类的字符。 这个条目总是匹配尽可能长的串；
    单个字符类跟一个 '-'， 将匹配零或更多个该类的字符。 和 '*' 不同， 这个条目总是匹配尽可能短的串；
    单个字符类跟一个 '?'， 将匹配零或一个该类的字符。 只要有可能，它会匹配一个；
    %n， 这里的 n 可以从 1 到 9； 这个条目匹配一个等于 n 号捕获物（后面有描述）的子串。
    %bxy， 这里的 x 和 y 是两个明确的字符； 这个条目匹配以 x 开始 y 结束， 且其中 x 和 y 保持 平衡 的字符串。 意思是，如果从左到右读这个字符串，对每次读到一个 x 就 +1 ，读到一个 y 就 -1， 最终结束处的那个 y 是第一个记数到 0 的 y。 举个例子，条目 %b() 可以匹配到括号平衡的表达式。
    %f[set]， 指 边境模式； 这个条目会匹配到一个位于 set 内某个字符之前的一个空串， 且这个位置的前一个字符不属于 set 。 集合 set 的含义如前面所述。 匹配出的那个空串之开始和结束点的计算就看成该处有个字符 '\0' 一样。
]]

--[[
    + 重复一次或者多次
    * 重复0次以上
    - 重复0次以上
    ? 可选部分[+-]? (后面可选)
--]]
local src = {}
for i in io.lines("./iotest.txt") do
    table.insert(src, i)
end

table.sort(src, function (a, b)  return string.lower(a) < string.lower(b) end)
local str = table.concat(src, ',')
print("str:",str)
local sbu = string.sub(str, -2) -- 返回末尾的字符
print("sbu:",sbu)

print(string.byte("abc ", 1, 4)) -- 返回一个范围 内的字符码

print(string.format("pi = %.5f", math.pi))

local y, m ,d = 2018, 1, 12
print(string.format("%04d/%02d/%02d", y, m ,d ))



local find = "hello world"
local i, j = string.find(find, "world") -- 查找字符串在其中的位置
print(i, j)
local data = "yiadas dad sad a 2018/01/12"
print(string.match(data, '%d+/%d+/%d+')) -- 返回存在的字符串

local s = string.gsub(find, "l", '2') -- 替换字符串内容 目标字符串，模式， 要替换进去的值
print(s)

local words = {}
for word in string.gmatch("Hello Lua user", "%a+") do -- 一个迭代器函数 字符串遍历
    words[#words + 1] = word
end
print(words)

-- 捕获
local pair = "name = Anna"
local k, v = string.match(pair, "(%a+)%s*=%s*(%a+)")
print(k,v)

-- txt 风格转化为xml
local sxml = "the \\quote{task} is to \\em{chenge} that."
local xml = string.gsub(sxml,"\\(%a+){(.-)}", "<%1>%2</%1>")
function trim(s)
    return string.gsub(s, "^%s*(.-)%s*$", "%1")
end
print(xml)
print(trim(xml))

function expand(s) -- 判断字符串对的函数是否有值
    return (string.gsub(s, "$(%w+)",function (e)
        return tostring(_G[e])
    end))
end
print(expand("print=$print; a=$a"))

function toxml(x)
    local s = string.gsub(x, "\\(%a+)(%b{})", function(tag, boay)
        local boay = string.sub(boay, 2, -2) -- 删除花括号
        boay = toxml(boay)
        return string.format("<%s>%s</%s>",tag,boay ,tag )
    end )
    return s
end

--print(toxml("\\title{The \\bold{big} example}"))
--print(toxml(sxml))


-- url 编码
local url = "";
function unescape(s)
    s = string.gsub(s, "+", "=")
    s = string.gsub(s, "%%(%x%x)", function (h)
        return string.char(tostring(h, 16))
    end)
    return s
end

local cgi = {}
function decode(s)
    for name , val in string.gmatch(s, "([^&=]+)=([^&=]+)")  do
        local name = unescape(name)
        local val = unescape(val)
        cgi[name] = val
    end
end

function escape(s)
    local s = string.gsub(s, "[&=+%%%c]",function (e)
        return string.format("%%%02X",string.byte(e))
    end)
    s = string.gsub(s," ", "+")
    return s
end

function encode(t)
    local b = {}
    for k, v in pairs(t) do
        b[#b + 1] = (escape(k) .. "=" .. escape(v))
    end
    return table.concat(b, "&")
end
decode("a=1&b=2&c=3")
dd(cgi)

local  t = {name = "a1", query="a+b=c",q="yes or no"}
print(encode(t))


-- table 扩展
print(string.match("hello world", "()or()")) --捕获or 前后字符串的位置

-- tab 制表符
function expandTable(s, tab)
    tab = tab or 8
    corr = 0
    local s = string.gsub(s, "()\t", function (p)
        local sp = tab - (p -1 + corr) %tab
        corr = corr -1 + sp
        return string.rep(" ", sp)
    end)
    return s
end

function unexpanTable(s, tab)
    local tab = tab or 8
    local s = expandTable(s)
    local pat = string.rep(".", tab)
    s = string.gsub(s, pat, "%0\1")
    s = string.gsub(s, "+\1", "\t")
    s = string.gsub(s, "\1", "")
    return s
end

print(unexpanTable(str))

