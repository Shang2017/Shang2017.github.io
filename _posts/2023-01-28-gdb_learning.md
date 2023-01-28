## 设置入口参数
gdb --args main.exe a.txt
(gdb)set args a.txt

## 断点 break tbreak rbreak
linenum
filename:linenum
+ offset
- offset
function
filename:function

tbreak 一次
rbreak regex 作用于函数的开头

info break
clear num
delete num


## watch rwatch awatch
watch  写就停止
rwatch 有读操作就停止
awatch 读或写就停止

info watchpoints

## 条件断点
info break

condition 1 num==3
condition 2 n>3


## print/display

display /fmt expr
fmt /x /d /u /o /t(binary) /f /c
info display
undisplay num
delete display num

## 搜索源代码
search <regexp>
reverse-search <regex>


