cmake_minimum_required(VERSION 3.19)

project(ipemain
        VERSION 1.0
        LANGUAGES Fortran)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMakeModules/Modules)

find_package(hdf5 1.10.6 REQUIRED)
find_package(netcdf 4.7.4 REQUIRED)
find_package(ESMF 8.4.0 MODULE REQUIRED)
find_package(bacio 2.4.10 REQUIRED)
find_package(sp 2.3.3 REQUIRED)
find_package(w3nco 2.4.1 REQUIRED)
find_package(pnetcdf 1.11.2 REQUIRED)
find_package(comio 0.0.8 REQUIRED)

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
