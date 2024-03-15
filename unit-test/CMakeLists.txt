cmake_minimum_required(VERSION 3.24)

project(CppLearn
    VERSION 1.0
    LANGUAGES CXX)

add_executable(CppLearn main.cpp)    

target_compile_features(CppLearn PUBLIC cxx_std_17)

enable_testing()
add_subdirectory(Test)