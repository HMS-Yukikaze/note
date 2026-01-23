include(FetchContent)

FetchContent_Declare(fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git)
FetchContent_MakeAvailable(fmt)

add_executable(Test
  hello_test.cpp
)

target_link_libraries(Test 
    PUBLIC fmt
)