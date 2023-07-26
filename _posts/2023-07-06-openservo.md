## 查看windows版本
winver


## 电流传感器

zxct1009 高边带电流监视器

## Mosfet H-Bridge

## 马达知识

https://www.nidec.com/cn/technology/motor/basic/00013/
https://acroname.com/blog/all-about-back-emf-motion-control

反电动势 e=KeW   ke v/rad   W rad/s


## 开源项目

大功率马达驱动   https://github.com/rene-dev/stmbl     It can power motors of up to 2.2kW and up to around 380V DC bus voltage
串口界面工具    https://github.com/dukelec/cdbus_gui
cheatah 开源电机控制        https://github.com/bgkatz
                          https://github.com/mit-biomimetics/Cheetah-Software
                          https://zhuanlan.zhihu.com/p/79391139
    
开源云台   simplebgc/storm32

https://www.amobbs.com/thread-5755097-1-1.html

开源电调

https://github.com/codenocold/dgm/tree/main
https://blog.csdn.net/supperzhan/article/details/114597408
https://www.bilibili.com/video/BV1294y1o7bG/
https://github.com/mjbots/moteus
https://github.com/Misfittech/nano_stepper
https://github.com/makerbase-mks/MKS-SERVO42B/tree/master

lua

https://github.com/lqt5/lqt/tree/qt5  lua qt5
https://github.com/momotech/MLN       lua 移动
    


## xtoolbox

1. lua 中 . 和 ： 的区别
xx.yy(x,y,z) 传输的参数是x,y,z
xx:yy(x,y,z) 传输的参数是self,x,y,z
所以类函数用 .定义
成员函数用  : 定义


## am32-mutimoto-esc 编译

1. 添加宏定义 HARDWARE_GROUP_F0_A
2. 添加include路径： mcu/f051/inc

## ethos suit 环境

1. electron 安装需设一下镜像
  yarn config set ELECTRON_MIRROR http://npm.taobao.org/mirrors/electron/









