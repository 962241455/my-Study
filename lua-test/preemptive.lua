

-- preemptive 多线程
require("socket")
dofile("libl.lua")
host = "www.w3.org"
-- file_url = "/TR/REC-html32.html"
-- file_url = "/1999/xhtml"




-- 下载方法
function download(host, file)
	local a = assert(socket.connect(host, 80))
	local count = 0 
	a:send("GET" .. file .. "HTTP/1.0\r\n\r\n")

	while true do
		local s, status, partial = receive(a)
		count = count + #(s or partial)
        io.write(s or partial)
		if status == "closed" then break end
	end
    a:close()
    print(file, count)
end

function receive(connention)
    connention:settimeout(0)
    local s, status, partial = connention:receive(2^10)
    if status == "timeout" then
        coroutine.yield(connention)
    end
    return s , status, partial
end

local therads = {}
function get(host, file)
    local co = coroutine.create(function ()
        --疑问，这里为什么没有传进去
        download(host,file) 
    end)
    table.insert(therads, co)
end

    
function dispatch()
    local i = 1
    local connentions = {}
    if #therads > 0 then
        while i <= #therads  do 
            if therads[i] == nil then
                if therads[1] == nil then
                    i = 1
                    connentions = {}
                end
            end
            -- print(coroutine.status(therads[i]))
            local status , res = coroutine.resume(therads[i])
            print("dispatch :", res)
            if not res then 
                table.remove(therads, i)
            else
                i = i + 1
                connentions[#connentions + 1] = res
                if #therads == #connentions then
                    socket.select(connentions)
                end
            end
        end
    else
        print("not nil")
    end
end

-- get(host, "/TR/html401/html40.txt")
-- get(host, "/TR/REC-html32.html")
-- get(host, "/TR/html401/html40.txt")
-- get(host, "/TR/REC-html32.html")

-- dispatch()









