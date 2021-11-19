include(FetchContent)
include(NApiGetMaxVersion)

set(napi_node_mirror "https://nodejs.org/dist" CACHE STRING "nodejs download mirror")
set(napi_iojs_mirror "https://iojs.org/dist" CACHE STRING "iojs download mirror")
set(napi_electron_mirror "https://atom.io/download/atom-shell" CACHE STRING "electron download mirror")

execute_process(COMMAND node "--version" OUTPUT_VARIABLE node_runtime_version)
set(napi_runtime_version "${node_runtime_version}" CACHE STRING "node runtime version")
message(STATUS "node runtime version: ${node_runtime_version}")
#file(READ package.json package_json)
#string(JSON package_json_binary GET ${package_json} "binary")
#string(JSON package_json_binary GET ${package_json} "napi_versions")


FetchContent_Declare(node_headers
    URL "${napi_node_mirror}/${napi_runtime_version}/node-${napi_runtime_version}-headers.tar.gz"
)
FetchContent_MakeAvailable(node_headers)
FetchContent_GetProperties(node_headers SOURCE_DIR node_headers_src)
set(node_headers_inc_dir "${node_headers_src}/include/node")
message(STATUS "headers: ${node_headers_inc_dir}")
get_napi_max_version("${node_headers_inc_dir}/node_version.h")
set(NAPI_VERSION ${napi_max_version} CACHE STRING "used napi version")

if(WIN32)
    set(node_lib_url "${napi_node_mirror}/${napi_runtime_version}")
    set(node_lib_name "node.lib")
    # does anyone need 32bit currently? If yes - add a PR :D
    set(node_lib_url "${node_lib_url}/win-x64/${node_lib_name}")
    set(node_lib_loc "${CMAKE_CURRENT_BINARY_DIR}/${node_lib_name}")
    file(DOWNLOAD "${node_lib_url}" "${node_lib_loc}" SHOW_PROGRESS)
    add_library(napi STATIC IMPORTED GLOBAL)
    set_target_properties(napi PROPERTIES
        IMPORTED_LOCATION "${node_lib_loc}"
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
