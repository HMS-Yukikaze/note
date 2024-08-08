
cmake_minimum_required(VERSION 3.24)

Project(CMakeNote LANGUAGES CXX)

add_subdirectory(singleton)

add_executable(designed_pattern main.cpp)

target_link_libraries(designed_pattern PRIVATE singleton)