cmake_minimum_required(VERSION 3.19)

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -g -O2 -fp-model source -ftz -align array64byte -xCORE-AVX2 -qno-opt-dynamic-align")

list(APPEND ipe_files
        IPE_Common_Routines.F90
        IPE_Constants_Dictionary.F90
	      IPE_Electrodynamics_Class.F90
        IPE_Forcing_Class.F90
        IPE_Grid_Class.F90
        IPE_Model_Class.F90
        IPE_Model_Parameters_Class.F90
	      IPE_MPI_Layer_Class.F90
        IPE_Neutrals_Class.F90
        IPE_Plasma_Class.F90
        IPE_Precision.F90
        IPE_Time_Class.F90
)

add_subdirectory(shared)
add_subdirectory(dynamo)
add_subdirectory(empirical_efield)
add_subdirectory(flip)
add_subdirectory(msise00)

add_library(ipe ${ipe_files})

set_target_properties(ipe PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod)

target_include_directories(ipe INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>
                                         $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib>
                                         $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/dynamo>
                                         $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/empirical_efield>
                                         $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/flip>
                                         $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/msise00>
                                         $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/ipelib/shared>
                                         )
                                 target_link_libraries(ipe PUBLIC COMIO)
target_link_libraries(ipe PUBLIC dynamo efield flip msise shared)


###############################################################################
### Install
###############################################################################
install(TARGETS ipe
        EXPORT  ipe-config
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(EXPORT      ipe-config
        DESTINATION lib/cmake)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

###############################################################################
### Done
###############################################################################
