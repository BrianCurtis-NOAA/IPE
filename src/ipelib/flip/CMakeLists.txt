cmake_minimum_required(VERSION 3.19)

list(APPEND flip_files
        CTIPE-int.f
        CMINOR.f
        ELECXS.f
        FLIP_GRID.f
        INIT-PROFILES.f
        KEMPRN.f
        MINORA.f
        Neut_Heating.f
        Photoel-Freqs.f
        RSDENA_EXB.f
        RSJACA.f
        RSLPSD.f
        RSLPST.f
        RSPE2B.f
        RSPRIM.f
        RSTEMC_EXB.f
        Rates.f
)

add_library(flip ${flip_files})

set_target_properties(flip PROPERTIES Fortran_MODULE_DIRECTORY
                                     ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(flip INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>)

###############################################################################
### Install
###############################################################################
install(TARGETS flip
        EXPORT  flip-config
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(EXPORT      flip-config
        DESTINATION lib/cmake)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

###############################################################################
### Done
###############################################################################
