macro(get_napi_max_version m_napi_version_file)
    file(READ "${m_napi_version_file}" m_file_cnt)

    string(REGEX MATCH "#define NAPI_VERSION *([0-9]*)" _ "${m_file_cnt}")
    set(napi_max_version ${CMAKE_MATCH_1})
    message(STATUS "napi max version: ${m_napi_version_file} -- ${CMAKE_MATCH_1}")
endmacro()
