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
