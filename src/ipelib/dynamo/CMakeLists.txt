cmake_minimum_required(VERSION 3.19)

add_library(dynamo)

set_target_properties(dynamo PROPERTIES Fortran_MODULE_DIRECTORY
                                     ${CMAKE_CURRENT_BINARY_DIR}/mod)
target_include_directories(dynamo INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/mod>
                                         $<INSTALL_INTERFACE:mod>)

list(APPEND dynamo_files
        cons_module.f
        dynamo_module.f
        heelis_module.f
        module_ceee.f
        module_clearcee.f
	      module_cnm.f
        module_cnmmod.f
        module_colath.f
        module_divide.f
        module_edges.f
        module_flwv32.f
	      module_highlat.f
        module_htrpex.f
        module_init_cons.f
        module_init_heelis.f
        module_magfield.f
	      module_potm.f
        module_rhspde.f
        module_stencil.f
        module_stencmd.f
	      module_stenmd.f
        module_stenmod.f
        module_sub_dynamo.f
        module_sub_heelis.f
        module_threed.f
      	module_transf.f
        module_weimer2005Ipe.f
        mudcom.f
        mud.f
        mudmod.f
        muh2cr.f
        params.f
        util.f
)

###############################################################################
### Install
###############################################################################
install(TARGETS dynamo
        EXPORT  dynamo-config
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(EXPORT      dynamo-config
        DESTINATION lib/cmake)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod DESTINATION ${CMAKE_INSTALL_PREFIX})

###############################################################################
### Done
###############################################################################
