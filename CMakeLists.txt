cmake_minimum_required(VERSION 3.3 FATAL_ERROR)
project(JahMiner)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(Qt5 REQUIRED COMPONENTS Widgets Network)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)

## OPENCL
        find_path(OpenCL_INCLUDE_DIR
        NAMES
            CL/cl.h
            OpenCL/cl.h
        NO_DEFAULT_PATH
        PATHS
            ENV "OpenCL_ROOT"
            ENV AMDAPPSDKROOT
            ENV ATISTREAMSDKROOT
            ENV "PROGRAMFILES(X86)"
            /usr
        PATH_SUFFIXES
            include
            OpenCL/common/inc
            "AMD APP/include")

    find_library(OpenCL_LIBRARY
        NAMES
            OpenCL
            OpenCL.lib
        NO_DEFAULT_PATH
        PATHS
            ENV "OpenCL_ROOT"
            ENV AMDAPPSDKROOT
            ENV ATISTREAMSDKROOT
            ENV "PROGRAMFILES(X86)"
        PATH_SUFFIXES
            "AMD APP/lib/x86_64"
            lib/x86_64
            lib/x86_64-linux-gnu
            lib/x64
            OpenCL/common/lib/x64)
    # find package will use the previews searched path variables
    find_package(OpenCL)
    if(OpenCL_FOUND)
        include_directories(SYSTEM ${OpenCL_INCLUDE_DIRS})
        set(LIBS ${LIBS} ${OpenCL_LIBRARY})
        link_directories(${OpenCL_LIBRARY})
                #target_link_libraries(${CMAKE_PROJECT_NAME} ${OpenCL_LIBRARY} )
    else()
        message(FATAL_ERROR "OpenCL NOT found: use `-DOpenCL_ENABLE=OFF` to build without OpenCL support for AMD gpu's")
    endif()

option (BUILD_AS_LIB "if the miner is in jahshaka")
if(BUILD_AS_LIB)
    set(HEADERS autominer.h cuda_gpu_list.h minerchart.h minerui.h switch.h  minerprocess.h)
    add_library(JahMiner main.cpp autominer.cpp cuda_gpu_list.cu minerchart.cpp minerui.cpp switch.cpp minerprocess.cpp ${HEADERS_moc})
else()
    set(HEADERS autominer.h constants.h cuda_gpu_list.h minerchart.h minerui.h qtawesome.h qtawesomeanim.h switch.h settingsmanager.h minerprocess.h)
    add_executable(JahMiner WIN32 main.cpp autominer.cpp constants.cpp cuda_gpu_list.cu minerchart.cpp minerui.cpp qtawesome.cpp qtawesomeanim.cpp switch.cpp settingsmanager.cpp minerprocess.cpp ${HEADERS_moc})

    if(WIN32 AND CMAKE_BUILD_TYPE STREQUAL Release)
        set(CMAKE_WIN32_EXECUTABLE ON)
    endif()
endif(BUILD_AS_LIB)

if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to 'Debug' as none was specified.")
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Disable compiler specific warnings if we are building with MSVC
# NOMINMAX - http://www.suodenjoki.dk/us/archive/2010/min-max.htm
if(MSVC)
    add_definitions("-D_CRT_SECURE_NO_WARNINGS" "-DNOMINMAX")
    # Disable ZERO_CHECK if need be
    # set(CMAKE_SUPPRESS_REGENERATION true)
endif()

  #  qt5_wrap_cpp(HEADERS_moc autominer.h constants.h cuda_gpu_list.h minerchart.h minerui.h qtawesome.h qtawesomeanim.h switch.h settingsmanager.h minerprocess.h)

target_link_libraries(JahMiner Qt5::Widgets Qt5::Network)
target_link_libraries(JahMiner ${LIBS})

