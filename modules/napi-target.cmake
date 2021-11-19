message(STATUS "using napi version ${NAPI_VERSION}")
if(WIN32)
    add_library(napi STATIC IMPORTED GLOBAL)
    set_target_properties(napi PROPERTIES
        IMPORTED_LOCATION "${node_lib_file}"
        INTERFACE_INCLUDE_DIRECTORIES "${node_headers_inc_dir}"
    )
else()
    add_library(napi INTERFACE IMPORTED GLOBAL)
    set_target_properties(napi PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${node_headers_inc_dir}"
    )
endif()
target_compile_definitions(napi INTERFACE NAPI_VERSION=${NAPI_VERSION})
add_library(node::napi ALIAS napi)
