set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -g -O2 -fp-model source -ftz -align array64byte -xCORE-AVX2 -qno-opt-dynamic-align")

if(DEBUG)
        set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -O0 -g -traceback -check pointer,stack,uninit")
endif()

