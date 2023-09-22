cmake_minimum_required(VERSION 3.19)

project(ipemain
        VERSION 1.0
        LANGUAGES Fortran)

find_package(ESMF 8.4.0 MODULE REQUIRED)

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
