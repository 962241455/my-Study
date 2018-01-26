-- os 相关操作
dofile("libl.lua")
--[[
    os.time() -- 返回一个时间戳 若不带参数则返回当前时间table的字段
    year, month, day, hour, min, sec, isdst
--]]
print(os.time{year=2018, month=1,day=1,hour=0})
t = os.time({year=2018, month=1,day=16,yday= 259,wday=4,hour=23,min=48,sec=10,isdst=false})
print(t)


--[[

    os.date ([format [, time]\])
    功能：返回一个按format格式化日期、时间的字串或表
      "!":按格林尼治时间进行格式化。
      "*t":将返一个带year(4位),month(1-12), day (1--31), hour (0-23), min (0-59), sec (0-61), wday (星期几, 星期天为1), yday (年内天数)
    %a      一星期中天数的简写                      （Wed）
    %A      一星期中天数的全称                      （Wednesday）
    %b      月份的简写                                  （Sep）
    %B      月份的全称                                  （September）
    %c      日期和时间                                   （09/16/98 23:48:10）
    %d      一个月中的第几天                          （16）[0 ~ 31]
    %H      24小时制中的小时数                      （23）[00 ~ 23]
    %I      12小时制中的小时数                       （11）[01 ~ 12]
    %j      一年中的第几天                             （259）[01 ~ 366]
    %M      分钟数                                       （48）[00 ~ 59]
    %m      月份数                                       （09）[01 ~ 12]
    %P      "上午(am)" 或 "下午(pm)"               (pm)
    %S      秒数                                          （10）[00 ~ 59]
    %w      一星期中的第几天                         （3）[0 ~ 6 = 星期天 ~ 星期六]
     %W     一年中的第几个星期      0 ~ 52
    %x      日期                                          （09/16/98）
    %X      时间                                          （23:48:10）
    %y      两位数的年份                               （90）[00 ~ 99]
    %Y      完整的年份                                 （2009）
    %%      字符串'%'
--]]
print(os.date("today is %A, in %B"))
local day = os.date("%Y/%m/%d", 1516117690)
print(day)

-- os.clock () 返回一个程序使用CPU时间的一个近似值
local x = os.clock ()
print(x)
--local s = 0
--for i = 1, 100 do s = s + i; end
--print(string.format("elapsed time : %.3f\n", os.clock() - x));


--[[
 os.getenv (varname)  返回当前进程的环境变量varname的值,若变量没有定义时返回nil
    print(os.getenv("USERDOMAIN"))
    print(os.getenv("SystemRoot"))
    print(os.getenv("Os2LibPath"))
    print(os.getenv("ProgramFiles" ))
    print(os.getenv("APPDATA" ))
    print(os.getenv("ALLUSERSPROFILE" ))
    print(os.getenv("CommonProgramFiles" ))
    print(os.getenv("COMPUTERNAME" ))
    print(os.getenv("USERNAME"))
    print(os.getenv("USERPROFILE" ))
    print(os.getenv("ComSpec"))
    print(os.getenv("LOGONSERVER" ))
    print(os.getenv("NUMBER_OF_PROCESSORS" ))
    print(os.getenv("OS"))
    print(os.getenv("PATHEXT" ))
    print(os.getenv("PROCESSOR_ARCHITECTURE" ))
    print(os.getenv("PROCESSOR_IDENTIFIER" ))
    print(os.getenv("PROCESSOR_LEVEL" ))
    print(os.getenv("PROCESSOR_REVISION" ))
    print(os.getenv("USERDOMAIN"))
    print(os.getenv("SystemRoot" ))
    print(os.getenv("TEMP"))
--]]
print(os.getenv("SystemRoot"))


--相当于C的system函数,返回系统状态码 , 可以运行一条系统命令
function ereateDir(mame)
    os.execute (mame)
end
--os.execute("pause") -- 返回系统状态码
--ereateDir("lua hello.lua")


--[[
  os.setlocale (locale [, category])
    设置程序的当前设置,函数返回最新的值，失败则返回nil
    参数：
    locale：一个指定当前设置的字串
    "":一个空字串，当前设置被视为本地设置
    "c":当前设置被视为标准c设置
    nil:返回category指示设置名的当前值
    category：一个描述要更改的设置名
    "all"[默认], "collate", "ctype", "monetary", "numeric", "time"
--]]
--print(os.setlocale('', 'time'))

--功能：返回一个临时文件名
os.tmpname()


-- os.remove (filename) 删除文件或一个空目录,若函数调用失败则返加nil加错误信息

--os.rename (oldname, newname) 更改一个文件或目录名,若函数调用失败则返加nil加错误信息

-- os.exit()  终止程序执行

-- os.difftime (t2, t1)功能：返回t1到t2相差的秒数

t1 = os.time();
for i = 0, 100 do
    os.time();
end
t2 = os.time();
print(os.difftime(t2, t1));

















