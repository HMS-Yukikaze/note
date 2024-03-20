cmake_minimum_required(VERSION 3.24)

project(test)
cmake_policy(SET CMP0144 NEW)
#设置boost库搜索路径
set(BOOST_ROOT /YourPath/Desktop/3rd/boost_1_84_0) 
set(Boost_NO_SYSTEM_PATHS ON)

set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
set(Boost_USE_STATIC_RUNTIME OFF)

find_package(Boost 
    COMPONENTS    regex
    REQUIRED
)

if(Boost_FOUND)
    MESSAGE( STATUS "Boost_INCLUDE_DIRS = ${Boost_INCLUDE_DIRS}.")
    MESSAGE( STATUS "Boost_LIBRARIES = ${Boost_LIBRARIES}.")
    MESSAGE( STATUS "Boost_LIB_VERSION = ${Boost_LIB_VERSION}.")    
    add_executable(test main.cpp)
    target_include_directories(test PUBLIC ${Boost_INCLUDE_DIRS})
    target_link_libraries(test ${Boost_LIBRARIES})

    target_compile_features(test PUBLIC cxx_std_17)
    set_target_properties(test PROPERTIES CXX_EXTENSIONS OFF)
endif()



