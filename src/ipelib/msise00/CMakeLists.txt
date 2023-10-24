cmake_minimum_required(VERSION 3.19)

list(APPEND msise_files
        hwm14.f90
        physics_constants.f90
        physics_msis.f90
        utils_constants.f90
        utils_spline.f90
)

add_library(msise ${msise_files})

set_target_properties(msise PROPERTIES Fortran_MODULE_DIRECTORY
                                     ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(msise INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>)

target_link_libraries(msise shared)

###############################################################################
### Install
###############################################################################
install(TARGETS msise
        EXPORT  msise-config
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(EXPORT      msise-config
        DESTINATION lib/cmake)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

###############################################################################
### Done
###############################################################################
