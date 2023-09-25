cmake_minimum_required(VERSION 3.19)

project(ipemain
        VERSION 1.0
        LANGUAGES Fortran)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMakeModules/Modules)

set(DEBUG OFF CACHE BOOL "Enable DEBUG mode")

find_package(ESMF 8.4.0 MODULE REQUIRED)
find_package(COMIO 0.0.8 REQUIRED)

if(DEBUG)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Set type of build to Debug." FORCE)
else()
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Set type of build to Release." FORCE)
endif()


add_library(ipemain src/IPE_Driver.F90)

add_subdirectory(src)

set_target_properties(ipemain PROPERTIES Fortran_MODULE_DIRECTORY
                                     ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(ipemain INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>)

###############################################################################
### Install
###############################################################################
install(TARGETS ipemain
        EXPORT  ipemain-config
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(EXPORT      ipemain-config
        DESTINATION lib/cmake)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

###############################################################################
### Done
###############################################################################
