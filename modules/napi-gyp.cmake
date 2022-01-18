if(WIN32)
    set(node_headers_inc_dir "${node_root_dir}/include/node")
else()
    set(node_headers_inc_dir 
        "${node_root_dir}/deps/v8/include"
        "${node_root_dir}/deps/v8/include"
        "${node_root_dir}/deps/uv/include"
    )
    if(EXISTS "${node_root_dir}/src")
        set(node_headers_inc_dir ${node_headers_inc_dir} "${node_root_dir}/src")
    endif()
endif()
message(STATUS "headers: ${node_headers_inc_dir}")
set(NAPI_VERSION ${NAPI_VERSION} CACHE STRING "used napi version")

include(napi-target)
