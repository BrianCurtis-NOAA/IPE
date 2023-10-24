### IPE LIB ###
###############

add_subdirectory(ipelib)

list(APPEND ipm_files
        ipeCap.F90
        ipeMethods.F90
        IPE_Wrapper.F90
)

add_library(ipm ${ipm_files})

set_target_properties(ipm PROPERTIES Fortran_MODULE_DIRECTORY
                                     ${CMAKE_CURRENT_BINARY_DIR}/mod)

target_include_directories(ipm INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>)

target_link_libraries(ipm ipe esmf comio::comio)

###############################################################################
### Install
###############################################################################
install(TARGETS ipm
        EXPORT  ipm-config
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(EXPORT      ipm-config
        DESTINATION lib/cmake)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

###############################################################################
### Done
###############################################################################
