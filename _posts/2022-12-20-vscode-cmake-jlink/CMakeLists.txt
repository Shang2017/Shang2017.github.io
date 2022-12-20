cmake_minimum_required(VERSION 3.22)

# setup compiler settings
set(CMAKE_C_STANDARD          11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS        ON)
set(CMAKE_CXX_STANDARD        20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS      ON)


# project
set(PROJ_PATH   ${CMAKE_CURRENT_SOURCE_DIR})
message("Build type: " ${CMAKE_BUILD_TYPE})

#
# Core Project settings
#
project(glass)
enable_language(C CXX ASM)

#
# Core Mcu flags,instructions set and FPU setup
# Needs to be set properly for your MCU
#
set(CPU_PARAMETERS
     -mthumb
     
     #This needs attention to properly set for used MCU!!!!
     -mcpu=cortex-m0plus
     #-mfpu=None
     -mfloat-abi=soft
     )

# Set linker script
set(linker_script_SRC ${PROJ_PATH}/STM32G071G8UX_FLASH.ld)
set(EXECUTABLE     ${CMAKE_PROJECT_NAME})


#
# List of source files to compile
#
set(sources_SRCS
     #Put here your source files,one in each lin,rlative to CMakeLists.txt file location
     Core/Src/app_freertos.c
     Core/Src/gpio.c
     Core/Src/i2c.c
     Core/Src/main.c
     Core/Src/stm32g0xx_hal_msp.c
     Core/Src/stm32g0xx_hal_timebase_tim.c
     Core/Src/stm32g0xx_it.c
     Core/Src/syscalls.c
     Core/Src/sysmem.c
     Core/Src/system_stm32g0xx.c
     Core/Src/usart.c


     Core/Startup/startup_stm32g071g8ux.s

     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_cortex.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_dma.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_dma_ex.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_exti.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_flash.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_flash_ex.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_gpio.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_pwr.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_pwr_ex.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_rcc.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_rcc_ex.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_tim.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_hal_tim_ex.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_ll_dma.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_ll_exti.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_ll_gpio.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_ll_i2c.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_ll_rcc.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_ll_usart.c
     Drivers/STM32G0xx_HAL_Driver/src/stm32g0xx_ll_utils.c

     Middlewares/Third_Party/FreeRTOS/Source/croutine.c
     Middlewares/Third_Party/FreeRTOS/Source/event_groups.c
     Middlewares/Third_Party/FreeRTOS/Source/list.c
     Middlewares/Third_Party/FreeRTOS/Source/queue.c
     Middlewares/Third_Party/FreeRTOS/Source/stream_buffer.c
     Middlewares/Third_Party/FreeRTOS/Source/tasks.c
     Middlewares/Third_Party/FreeRTOS/Source/timers.c

     Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2/cmsis_os2.c

     Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM0/port.c

     Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c

     

)

#
# include directories
#
set(include_path_DIRS 
     # Put here your include dirs,one in each line,relative to CMakeLists.txt file location
     Core/Inc 
     Drivers/STM32G0xx_HAL_Driver/Inc
     Drivers/CMSIS/Device/ST/STM32G0xx/Include
     Drivers/CMSIS/Include
     Drivers/STM32G0xx_HAL_Driver/Inc/Legacy
     Middlewares/Third_Party/FreeRTOS/Source/include
     Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2
     Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM0

)

#
# Symbols definition
#
set(symbols_SYMB
    # Put here your symbols(preprocessor defines),one in each linker_script_SRC
    # Encapsulate them with double quotes for safety purpose
    "DEBUG"
    "STM32G071xx"
    "USE_FULL_LL_DRIVER"
    "CMSIS_device_header=<stm32g0xx.h>"
    "USE_HAL_DRIVER"
)

#
# Executable files
#
add_executable(${EXECUTABLE} ${sources_SRCS})

#
# include paths
#
target_include_directories(${EXECUTABLE} PRIVATE ${include_path_DIRS})

# project symbols
target_compile_definitions(${EXECUTABLE} PRIVATE ${symbols_SYMB})

#compiler options
target_compile_options(${EXECUTABLE} PRIVATE 
   ${CPU_PARAMETERS}
   -Wall 
   -Wextra 
   -Wpedantic  
   -Wno-unused-parameter
   # Full debug configuration
   -O0 -g3 -ggdb
)

# linker options
target_link_options(${EXECUTABLE} PRIVATE  
   -T${linker_script_SRC} 
   ${CPU_PARAMETERS} 
   -Wl,-Map=${CMAKE_PROJECT_NAME}.Map
   --specs=nosys.specs 
   -u _print_float     # STDIO FLOAT formating support
   -Wl,--start-group 
   -lc 
   -lm 
   -lstdc++ 
   -lsupc++  
   -Wl,--end-group 
   -Wl,--print-memory-usage
)


# Execute post-build to print size
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.hex
)

# Convert to bin file -> add condition check?
add_custom_command(TARGET ${EXECUTABLE} POST_BUILD 
  COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.bin
)

