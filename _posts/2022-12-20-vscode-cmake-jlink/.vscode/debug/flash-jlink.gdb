echo Flashing program...
target remote localhost:2331
set architecture cortex-m0plus
monitor reset
load
compare-sections
monitor halt