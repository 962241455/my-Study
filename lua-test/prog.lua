-- 二进制文件测试

local inp = assert(io.open(arg[1], "rb"))
local out = assert(io.open(arg[2], "wb"))

local data = inp:read("*all")
data = string.gsub(data,"\r\n", "\n")

io.write(data)
io.close()














