-- 测试默认输出文件
dofile("libl.lua")
io.write("write start\n")

--  默认的输入文件是命令行
--local cmd_content = io.read("*a")
--print("command line content:", cmd_content)

--[[
    io.input(file) -- 设置默认输入文件为
    io.open("test.lua", "r") -- 以只读方式打开文件
        r	以只读方式打开文件，该文件必须存在。
        w	打开只写文件，若文件存在则文件长度清为0，即该文件内容会消失。若文件不存在则建立该文件。
        a	以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。（EOF符保留）
        r+	以可读写方式打开文件，该文件必须存在。
        w+	打开可读写文件，若文件存在则文件长度清为零，即该文件内容会消失。若文件不存在则建立该文件。
        a+	与a类似，但此文件可读可写
        b	二进制模式，如果文件是二进制文件，可以加上b
        +	号表示对文件既可以读也可以写
    io.read()  默认输出文件第一行
        "*n"	读取一个数字并返回它。例：file.read("*n")
        "*a"	从当前位置读取整个文件。例：file.read("*a")
        "*l"（默认）	读取下一行，在文件尾 (EOF) 处返回 nil。例：file.read("*l")
        number	返回一个指定字符个数的字符串，或在 EOF 时返回 nil。例：file.read(5)
--]]
-- 设置默认的输入文件
files = io.input("iotest.txt")

--  以附加的方式打开只写文件
local file = io.open("iotest.txt",'r')

-- 检测obj是否一个可用的文件句柄
print("io.type", io.type(files))

-- local txt_content = io.read("*l")
--  txt_content = string.gsub(txt_content, "([\128-\255=])", function(c)  -- 做文本相关处理
--          return string.format("=%02X", string.byte(c))
--     end)
-- --io.write("txt_content content:", txt_content)

print("----------io.read()----------")

 for count = 1, math.huge do
     local line = io.read("*n")
     --local line = io.read("*l")
     --local line = io.read("*a")
     --local line = io.read(2)
     --local line = io.read(2^13)
     if line == nil then break end
     io.write(string.format("%6d",count)..'->', line, '\n')
 end

local pat = "(%S+)%s+(%S+)%s+(%S+)%s+"
for n1, n2, n3 in string.gmatch(io.read("*all"), pat) do
    local n1 = tonumber(n1)
    local n2 = tonumber(n2)
    local n3 = tonumber(n3)
    if n1 ~=nil and n2 ~= nil and n3 ~= nil then
        print(math.max(tonumber(n1),tonumber(n2),tonumber(n3)))
    end
end


-- 返回一个迭代函数,每次调用将获得文件中的一行内容,当到文件尾时
local lines = {}
for val in io.lines() do
    lines[#lines + 1] = val
     --io.write("io.lines:", val, '\n')
end
table.sort(lines)
--dd(lines)

print("-----------io.open()-----------")
local f = assert(io.open("iotest.txt",'r'))
local t = f:read("*line")
--io.stderr:write(t) -- C提供的方法
--io.stdin:write(t)
--io.stdout:write(t)
io.write(t)
f:close() -- 关闭文件



local BUFSIZE = 2^13 -- 8KB  读取大文件时， 提升性能

local f1 =io.input(arg[1])
local cc, lc ,wc =0, 0, 0
while true do
    local lineb, rest = f1:read(BUFSIZE, "*line")
    if not lineb then break end
    if rest then lineb = lineb .. resr .. '\n' end
    cc = cc + #lineb
    -- 统计快中间的单词数
    local _, t string.gsub(lineb,"%S+", "")
    wc = wc + t
    -- 统计行字数
    local _, n string.gsub(lineb,"\n", "\n")
    lc = lc + n
end
f1:close()
print(cc, lc, wc)

print("\n----------foote()----------")
--  设置和获取当前文件位置,成功则返回最终的文件位置
--[[
"set": 从文件头开始
"cur": 从当前位置开始[默认]
"end": 从文件尾开始
offset:默认为0
--]]
file:seek("end", -10)
print("file:seek", file:read("*a"))

function fsize(file)
    local current = file:seek() -- 获取文件当前位置
    local size = file:seek("end") -- 获取文件大小
    file:seek("set", current) -- 恢复位置
    return size
end
print(fsize(file))
-- 关闭打开文件
file:close()

-- 关闭默认输出文件
io.close()

-- 测试此时默认输出文件
io.write("io.write again")

-- 设置命令行为默认输出
io.output(io.stdout)

-- 以附加的方式打开只写文件
file_xie = io.open("iotest.txt", "a")

-- 在文件最后一行添加 Lua 注释
-- file_xie:write("\n--test")
file_xie:close()

-- io.tmpfile():返回一个临时文件句柄，该文件以更新模式打开，程序结束时自动删除
local tmpfile = io.tmpfile("iotest.txt")
print("io.tmpfile:", tmpfile)
-- io.flush(): 向文件写入缓冲中的所有数据
