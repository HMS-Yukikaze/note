cmake_minimum_required(VERSION 3.14)
project(test LANGUAGES CXX)

include(FetchContent)
FetchContent_Declare(
    Boost
    GIT_REPOSITORY https://github.com/boostorg/boost.git
    GIT_TAG boost-1.88.0       # ⚡ 使用具体版本 tag
)
set(Boost_LIBRARIES
            Boost::beast
            Boost::json
    )
FetchContent_MakeAvailable(Boost)



add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE Boost::beast)