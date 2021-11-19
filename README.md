# CMake for N-API 

## usage

```cmake
include(FetchContent)
FetchContent_Declare(
  napi
  GIT_REPOSITORY https://github.com/mathisloge/cmake-napi.git
  GIT_TAG        <current_hash>
)
FetchContent_MakeAvailable(napi)

add_library(mynodelib MODULE)

target_link_libraries(mynodelib PRIVATE node::napi)
```

## usage with node-pre-gyp


Inside your `CMakeLists.txt`: 
```cmake
include(FetchContent)

FetchContent_Declare(
  napi_modules
  GIT_REPOSITORY https://github.com/mathisloge/cmake-napi.git
  GIT_TAG        <tag>
)
FetchContent_MakeAvailable(napi_modules)
FetchContent_GetProperties(napi_modules SOURCE_DIR napi_src)
list(APPEND CMAKE_MODULE_PATH "${napi_src}/modules")
include(napi-gyp)


add_library(mynodelib MODULE)
target_link_libraries(mynodelib PRIVATE node::napi)
```


Your `binding.gyp`:

```
{
    'targets': [
        {
        'target_name': 'build-mytarget',
        'type': 'none',
        'actions': [
            {
                'action_name': 'configure',
                'message': 'configuring <target>...',
                'inputs': [],
                'outputs': ["<(module_path)/<node-module>"],
                'action': ['cmake', '.', '-B', 'build', '-DCMAKE_BUILD_TYPE=Release', '-DNAPI_VERSION=<(napi_build_version)', '-Dnode_root_dir=<(node_root_dir)', '-Dnode_lib_file=<(node_lib_file)'],
            },
            {
                'action_name': 'build',
                'message': 'Building <target>...',
                'inputs': [],
                'outputs': ["<(module_path)/<node-module>"],
                'action': ['cmake','--build', 'build-cmake', '--config Release'],
            },
        ]
        }
    ]
}


```
