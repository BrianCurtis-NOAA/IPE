cmake_minimum_required(VERSION 3.19)

add_library(efield)


set_target_properties(efield PROPERTIES Fortran_MODULE_DIRECTORY
                                     ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(efield INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>)

list(APPEND efield_files
        apex_sunloc_empirical.f
        efield_ipe.f
        weimer2005_ipe.f
)

###############################################################################
### Install
###############################################################################
install(TARGETS efield
        EXPORT  efield-config
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(EXPORT      efield-config
        DESTINATION lib/cmake)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

###############################################################################
### Done
###############################################################################
