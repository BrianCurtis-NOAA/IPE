### IPE LIB ###
###############

add_subdirectory(ipelib)

if(COUPLED)
        list(APPEND ipm_files
                ipeCap.F90
                ipeMethods.F90
                IPE_Wrapper.F90 )

        add_library(ipm ${ipm_files})
        
        add_dependencies(ipm ipe)

        target_compile_definitions(ipm PUBLIC -DHAVE_MPI=1 -DHAVE_COMIO=1 -DHAVE_ESMF=1)
        set_target_properties(ipm PROPERTIES Fortran_MODULE_DIRECTORY
                                             ${CMAKE_CURRENT_BINARY_DIR}/mod)

        target_link_libraries(ipm PRIVATE ipe)
        target_link_libraries(ipm PRIVATE ipe COMIO pnetcdf esmf NetCDF::NetCDF_Fortran)
        
        install(TARGETS ipm
                EXPORT  ipm-config
                LIBRARY DESTINATION lib
                ARCHIVE DESTINATION lib)

        install(EXPORT      ipm-config
                DESTINATION lib/cmake)

        install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

else()
        add_executable(ipe_model IPE_Driver.F90)
        target_compile_definitions(ipe_model PUBLIC -DHAVE_MPI=1 -DHAVE_COMIO=1 -DHAVE_ESMF=1)
        set_target_properties(ipe_model PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod)
        target_link_libraries(ipe_model PRIVATE ipe COMIO pnetcdf esmf NetCDF::NetCDF_Fortran)
endif()

###############################################################################
### Done
###############################################################################
