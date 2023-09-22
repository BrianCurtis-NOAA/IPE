cmake_minimum_required(VERSION 3.19)

add_library(ipeshared)

set_target_properties(ipeshared PROPERTIES Fortran_MODULE_DIRECTORY
                                     ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(ipeshared INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>)

list(APPEND ipeshared_files
        ipe_error_module.F90
)

###############################################################################
### Install
###############################################################################
install(TARGETS ipeshared
        EXPORT  ipeshared-config
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(EXPORT      ipeshared-config
        DESTINATION lib/cmake)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

###############################################################################
### Done
###############################################################################
