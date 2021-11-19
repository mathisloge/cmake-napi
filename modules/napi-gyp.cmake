
set(node_headers_inc_dir "${node_root_dir}/include/node")
message(STATUS "headers: ${node_headers_inc_dir}")
set(NAPI_VERSION ${NAPI_VERSION} CACHE STRING "used napi version")

include(napi-target)
