-- 协同程序
-- coroutine.create()	创建coroutine，返回coroutine
co = coroutine.create(function(i)  print(i)  end)
-- 启动或者重启 coroutine，和create配合使用
coroutine.resume(co, 1)   -- 1

print(coroutine.status(co))  -- dead
 
-- coroutine.wrap()	创建coroutine，返回一个函数
cow = coroutine.wrap( function(i)   print(i) end)

print('coroutine.wrap', cow(1))


 
co2 = coroutine.create(
    function()
        for i=1,10 do
            print(i)
            if i == 3 then
                -- 查看状态 coroutine的状态有四种：dead(死亡)，suspend(挂起)，running(运行)，normal(正常)
                print(coroutine.status(co2))  --running
                -- 当使用running的时候，就是返回一个corouting的线程号
                print(coroutine.running()) --thread:XXXXXX
            end
            -- 挂起coroutine，将coroutine设置为挂起状态
            coroutine.yield()
        end
    end
)
 
coroutine.resume(co2) --1
coroutine.resume(co2) --2
coroutine.resume(co2) --3
 
print(coroutine.status(co2))   -- suspended
print(coroutine.running())
 
print("---------上部分----------")
files = io.open("iotest.txt", "r")
print(io.type(files))
io.input(files)
function receive(pord)
    local status, value = coroutine.resume(pord)
    print("receive-> value", status, value)
    return value
end

function send (x)
    coroutine.yield(x)
end

function producer ()
    return coroutine.create(function ()
        while true do 
        local x = io.read("*a")
        print("producer -> x: ", x)
        send(x)
        end
    end)   
end


function filter(pord)
    return coroutine.create(function ()
        for line = 1, math.huge do
            local x = receive(pord)
            x = string.format("%5d %s", line, x)
            print("filter receive", x)
            send(x)
        end
    end)
end

function consumer (prod)
    local i = 1
    while true do
    local x = receive(prod)
    print("consumer receive", x)
    io.write(x, "\n")
    if i > 5 then
        break
    end
    i = i + 1
    end
end
io.close()
p = producer()
f = filter(p)
consumer(f)


-- 以协同实现迭代器
print("---------以协同实现迭代器-------------")
function permgen(a, n)
     n = n or #a 
    print(a)
    if n < 1 then
     coroutine.yield(a)   
    else
        for i=1, n do
            -- 将第一个元素 和 最后一个对调
            a[n] , a[i] = a[i], a[n]
            -- 递归生成其他元素排列
            permgen(a, n-1)
            -- 复原
            a[n] , a[i] = a[n], a[i]
        end
    end
end

-- 创建一迭代器 调用协同程序
function permutations(a)    
--    local pco = coroutine.create(function () permgen(a) end)
--    return function () --启动 协同程序
--        local code, res = coroutine.resume(pco)
--        print(coroutine.status(pco))
--        return res
--    end
    local pco = coroutine.wrap(function () permgen(a) end)
    return  pco
end

function printResult (a)
    for i=1, #a do
       print(a[i], '')
    end
    print("\n")
end

for p in permutations{"a","b","c"} do
    printResult(p)
end





