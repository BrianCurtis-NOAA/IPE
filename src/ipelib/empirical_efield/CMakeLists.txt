cmake_minimum_required(VERSION 3.19)

list(APPEND efield_files
        apex_sunloc_empirical.f
        efield_ipe.f
        weimer2005_ipe.f
)

add_library(efield ${efield_files})

add_dependencies(efield shared)

set_target_properties(efield PROPERTIES Fortran_MODULE_DIRECTORY
                                     ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(efield INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>)

target_link_libraries(efield shared)

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
