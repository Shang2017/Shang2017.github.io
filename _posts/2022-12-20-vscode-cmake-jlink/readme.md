#Vscode and STM32

## JlinkServer and stlink openocd
### JlinkServer
1. launch.json
   {
            "name": "J-Link (M4)",
            "type": "cppdbg",
            "request": "launch",
            //"program": "${workspaceFolder}/build/${config:program_file}",
            "program": "./build/Debug/glass.elf",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            
            "windows": {
                "miDebuggerPath": "arm-none-eabi-gdb.exe",
                //"debugServerPath": "C:/Program Files (x86)/SEGGER/JLink_V644h/JLinkGDBServerCL.exe",
                "debugServerPath": "L:/ST/STM32CubeIDE_1.6.1/STM32CubeIDE/plugins/com.st.stm32cube.ide.mcu.externaltools.jlink.win32_2.0.100.202110251254/tools/bin/JLinkGDBServerCL.exe",
            },
            
           
            "logging": {
                "exceptions": true,
                "trace": false,
                "traceResponse": false,
                "engineLogging": false
            },
            "miDebuggerServerAddress": "localhost:2331",
            "debugServerArgs": "-select USB -device STM32G071G8 -if SWD -halt -ir -speed auto -LocalhostOnly -nologtofile -JLinkScriptFile ${workspaceFolder}/.vscode/Reset.JLinkScript",
            //"debugServerArgs": "-select USB -device STM32G071G8 -if SWD -halt -ir -speed auto -LocalhostOnly -nologtofile",
            "serverStarted": "Connected to target",
            "filterStderr": false,
            "targetArchitecture": "arm",
            "customLaunchSetupCommands": [
                {"text":"-list-features"}
            ],
            "setupCommands": [
                { "text":"cd ${workspaceFolder}" },
                { "text":"file L:/ST/project/glass/build/Debug/glass.elf"},
                { "text":"set logging overwrite on"},
                { "text":"set logging file debug-arm.log"},
                { "text":"set logging off"},
                { "text":"exec-file ./build/Debug/glass.elf" },
                { "text":"symbol-file ./build/Debug/glass.elf" },
                { "text":"target remote localhost:2331" },
                { "text":"monitor reset" },
                { "text":"monitor halt"},
                { "text":"load"}，
                { "text":"set $pc=Reset_Handler" },
                { "text":"b main" },                
            ],
        },

        debugServerPath都行

### slink openocd
{
            "name": "Debug OPENOCD -STLinker-V2",
            "cwd": "${workspaceRoot}",
            "type": "cortex-debug",
           // "executable": "${command:cmake.launchTargetPath}", //or fixed file path:build/proj.elf
            "executable": "./build/Debug/glass.elf",
            "request": "launch",  //Use "attach" to connect target with elf download
            "servertype": "openocd",
            //"device": "STM32G071",
            "interface": "swd",
            "configFiles":[
                "I:/github/WORK/Alberto/openocd/share/openocd/scripts/interface/stlink-v2.cfg",    //使用ST-LINK
                "I:/github/WORK/Alberto/openocd/share/openocd/scripts/target/stm32g0x.cfg",      //根据芯片型号更改/stm32f1x.cfg
            ],
            "runToMain": true,
            //"serialNumber": "",
            //"runToEntryPoint": "main",
            "svdFile": "./stm32g071.svd",
            //"v1":false,
            //"showDevDebugOutput": "both",
            //will get automatically detected if STM32CubeIDE is installed to default directory
            //or it can be manually provided if necessary

            //"serverpath": "L:\\ST\\STM32CubeIDE_1.6.1\\STM32CubeIDE\\plugins\\com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.win32_2.0.100.202109301221\\tools\\bin\\ST-LINK_gdbserver.exe",
            //"armToolchainPath":"J:\\ChibiStudio1\\ChibiStudio\\tools\\GNU Tools ARM Embedded\\10.2 2020q4\\bin",
            //"stm32cubeprogrammer": "L:\\ST\\STM32CubeProg\\bin",

        },      

## stm32 and cmake
### VSCODE EXTENSION 

code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cmake-tools
code --install-extension twxs.cmake
code --install-extension marus25.cortex-debug
code --install-extension dan-c-underwood.arm
code --install-extension zixuanwang.linkerscript

### toolchain 

1.C编译参数： gcc -ffunction-sections -fdata-sections -Wl,–gc-sections 参数详解
  GCC链接操作是以section作为最小的处理单元，只要一个section中的某个符号被引用，该section就会被加入到可执行程序中去。因此，GCC在编译时可以使用 -ffunction-sections 和 -fdata-sections 将每个函数或符号创建为一个sections，其中每个sections名与function或data名保持一致。而在链接阶段， -Wl,–gc-sections 指示链接器去掉不用的section（其中-wl, 表示后面的参数 -gc-sections 传递给链接器），这样就能减少最终的可执行程序的大小了。
2. c++编译参数：-fno-rtti -fno-exceptions -fno-threadsafe-statics
3. cmake目录下，gcc-arm-eabi-none.cmake


# .cmake include in the presets.  we must selecft CMakePreset.json first.

#### Some default GCC settings
#### arm-none-eabi.cmake must be part of path environment
    set(TOOLCHAIN_PREFIX                arm-none-eabi-)
    set(FLAGS                           "-fdata-sections -ffunction-sections --specs=nano.specs -Wl,--gc-sections")
    set(CPP_FLAGS                       "-fno-rtti -fno-exceptions -fno-threadsafe-statics"
    # Define compiler settings
    set(CMAKE_C_COMPILER                ${TOOLCHAIN_PREFIX}gcc ${FLAGS})
    set(CMAKE_ASM_COMPILER              ${CMAKE_C_COMPILER})
    set(CMAKE_CXX_COMPILER              ${TOOLCHAIN_PREFIX}g++ ${FLAGS} ${CPP_FLAGS})
    set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PREFIX}objcopy)
    set(CMAKE_SIZE                      ${TOOLCHAIN_PREFIX}size)

    set(CMAKE_EXECUTABLE_SUFFIX_ASM     ".elf")
    set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
    set(CMAKE_EXECUTABLE_SUFFIX_CXX     ".elf")

    set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

### CMakeLists.txt
cmake_minimum_required(VERSION 3.22)

# SETTING CONPILER SETTINGS

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

set(PROJ_PATH ${CMAKE_CURRENT_SOURCE_DIR})
message("Build type:" ${CMAKE_BUILD_TYPE})

# Core Project settings

project(NAME)
enable_language(C CXX ASM)

# core MCU FLAGS for compile and link

set(CPU_PARAMETERS
   -mthumb
   -mcpu=cortex-m0plus
   # -mfpu=
   -mfloat=soft
   )

# set liner script
set(link_script_SRC ${PROJ_PATH}/*.ld)
set(EXECUTABLE ${CMAKE_PROJECT_NAME})

# list of src files
set(sources_SRCS
    #put name
)

# include directories
set(include_path_DIRS 
#put name
)

# symbol definition
set(symbol_SYMB 
#pur symbol
)

# executable file
add_executable(${EXECUTABLE} ${sources_SRCS})

# include
target_include_directories(${EXECUTABLE} PRIVATE ${include_path_DIRS})

# project symbol
target_compile_definitions(${EXECUTABLE} PRIVATE ${symbol_SYMB})

target_compile_options(${EXECUTABLE} PRIVATE
  ${CPU_PARAMETERS}
  -Wall
  -Wextra
  -Wpedantic
  -Wno-unused-parameter
  -Og -g3 -ggdb
  )

  # linker options

  taget_link_options(${EXECUTABLE} PRIVATE
    -T${liner_script_SRC}
    ${CPU_PARAMETER}
    -WL,Map=${CMAKE_PROJEXT_NAME}.map
    --specs=nosys.specs
    -u print_float
    -Wl,-start_group
    -lc
    -lm
    -lstdc++
    -lsupc++
    -Wl,--end_group
    -Wl, --print-memory-usage

  )

  # execute post build to print size
  add_custom_command(T  arget ${EXECUTABLE} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${EXECUTABLE}>
    )

    # CONVER HEX 
  add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.hex
    )
  
  # convert to bin
  add_custom_command(TARGET ${EXECUTABLE} -O binary $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.BIN 
  )


  ## task.json
  
