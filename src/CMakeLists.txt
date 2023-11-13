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

        set_target_properties(ipm PROPERTIES Fortran_MODULE_DIRECTORY
                                             ${CMAKE_CURRENT_BINARY_DIR}/mod)

        target_include_directories(ipm INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                                 $<INSTALL_INTERFACE:mod>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/dynamo>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/empirical_efield>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/flip>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/msise00>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/shared>
                                                 )

        target_link_libraries(ipm PRIVATE ipe)
        
        install(TARGETS ipm
                EXPORT  ipm-config
                LIBRARY DESTINATION lib
                ARCHIVE DESTINATION lib)

        install(EXPORT      ipm-config
                DESTINATION lib/cmake)

        install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

else()
        add_executable(ipe_model IPE_Driver.F90)
        target_compile_definitions(ipe_model PUBLIC -DHAVE_MPI=1 -DHAVE_COMIO=1 -DHAVE_ESMF=1 -lcomio)
        set_target_properties(ipe_model PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod)
        target_include_directories(ipe_model INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                                       $<INSTALL_INTERFACE:mod>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/dynamo>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/empirical_efield>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/flip>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/msise00>
                                                 $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/shared>
                                                       )
                                               target_link_libraries(ipe_model PRIVATE ipe COMIO hdf5 z pnetcdf esmf NetCDF::NetCDF_Fortran)
endif()

###############################################################################
### Done
###############################################################################
