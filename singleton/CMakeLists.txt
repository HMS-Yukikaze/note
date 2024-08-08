file(GLOB HEADERS 
    ${CMAKE_CURRENT_LIST_DIR}/*.hpp
    )
# 目标
add_library(singleton INTERFACE)
target_include_directories(singleton INTERFACE ${MY_HEADER_DIR})