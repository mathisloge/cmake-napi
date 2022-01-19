if(WIN32 OR EXISTS "${node_root_dir}/include/node")
    set(node_headers_inc_dir "${node_root_dir}/include/node")
else()
    set(node_headers_inc_dir 
        "${node_root_dir}/deps/v8/include"
        "${node_root_dir}/deps/v8/include"
        "${node_root_dir}/deps/uv/include"
        "${node_root_dir}/src"
    )
endif()
message(STATUS "headers: ${node_headers_inc_dir}")
set(NAPI_VERSION ${NAPI_VERSION} CACHE STRING "used napi version")

include(napi-target)
