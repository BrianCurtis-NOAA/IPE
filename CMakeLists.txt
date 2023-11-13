cmake_minimum_required(VERSION 3.19)

project(ipe
        VERSION 1.0
        LANGUAGES Fortran)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMakeModules/Modules)

set(DEBUG OFF CACHE BOOL "Enable DEBUG mode")
set(COUPLED OFF CACHE BOOL "Build IPE as coupled component")
set(OPENMP ON CACHE BOOL "Enable OpenMP threading")

find_package(COMIO 0.0.10 REQUIRED)
find_package(HDF5 REQUIRED COMPONENTS Fortran)
find_package(ZLIB REQUIRED)
find_package(PnetCDF REQUIRED COMPONENTS Fortran)
find_package(ESMF 8.4.0 MODULE REQUIRED)
find_package(NetCDF REQUIRED COMPONENTS Fortran)

if(DEBUG)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Set type of build to Debug." FORCE)
else()
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Set type of build to Release." FORCE)
endif()

add_subdirectory(src)
