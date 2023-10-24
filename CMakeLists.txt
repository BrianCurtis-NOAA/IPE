cmake_minimum_required(VERSION 3.19)

project(ipe
        VERSION 1.0
        LANGUAGES C CXX Fortran)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMakeModules/Modules)

set(DEBUG OFF CACHE BOOL "Enable DEBUG mode")

find_package(ESMF 8.4.0 MODULE REQUIRED)
find_package(comio 0.0.10 REQUIRED)

if(DEBUG)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Set type of build to Debug." FORCE)
else()
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Set type of build to Release." FORCE)
endif()

add_subdirectory(src)

add_executable(ipe_model src/IPE_Driver.F90)
add_dependencies(ipe_model ipm)
set_target_properties(ipe_model PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(ipe_model PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>)
target_include_directories(ipe_model PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src/ipelib>)
target_link_libraries(ipe_model PRIVATE ipm esmf comio::comio)
