
-- lua sql  学习
dofile("libl.lua")

--dg()
-- 随机数
local num =  math.random(2,6)

-- 随机数生成的种子
local num1 = math.randomseed(os.time())
print(num)
