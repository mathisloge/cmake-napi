
set(node_headers_inc_dir 
    "${node_root_dir}/include/src"
    "${node_root_dir}/deps/v8/include"
    "${node_root_dir}/deps/v8/include"
    "${node_root_dir}/deps/uv/include"
)
message(STATUS "headers: ${node_headers_inc_dir}")
set(NAPI_VERSION ${NAPI_VERSION} CACHE STRING "used napi version")

include(napi-target)
