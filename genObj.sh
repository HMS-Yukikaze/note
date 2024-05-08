#!/bin/bash

# 你的项目名称
PROJECT_NAME="OBCodeDemo"

# Create directory structure
mkdir -p ./$PROJECT_NAME/build
mkdir -p ./$PROJECT_NAME/example
mkdir -p ./$PROJECT_NAME/doc
mkdir -p ./$PROJECT_NAME/unittest
mkdir -p ./$PROJECT_NAME/test
mkdir -p ./$PROJECT_NAME/deps
mkdir -p ./$PROJECT_NAME/tools
mkdir -p ./$PROJECT_NAME/script
mkdir -p ./$PROJECT_NAME/include
mkdir -p ./$PROJECT_NAME/src

# Create a sample hello.hpp file
cat << EOF > ./$PROJECT_NAME/include/hello.hpp
#ifndef HELLO_HPP
#define HELLO_HPP

void say_hello();

#endif // HELLO_HPP
EOF

# Create a sample hello.cpp file
cat << EOF > ./$PROJECT_NAME/src/hello.cpp
#include "hello.hpp"
#include <iostream>

void say_hello(){
    std::cout << "Hello, CMake World!" << std::endl;
}
EOF

# Create a sample main.cpp file
cat << EOF > ./$PROJECT_NAME/src/main.cpp
#include "hello.hpp"

int main() {
    say_hello();
    return 0;
}
EOF

# Create the CMakeLists.txt file
cat << EOF > ./$PROJECT_NAME/CMakeLists.txt
cmake_minimum_required(VERSION 3.24)

project(HelloCMake LANGUAGES CXX)

# Include directory for hello.hpp
include_directories(\${CMAKE_SOURCE_DIR}/include)

# Add executable target
add_executable(\${PROJECT_NAME} src/main.cpp src/hello.cpp)

add_definitions(-DUNICODE -D_UNICODE)

# Specify C++ standard
target_compile_features(HelloCMake PUBLIC cxx_std_17)
set_target_properties(HelloCMake PROPERTIES CXX_EXTENSIONS OFF)

EOF

echo "Project $PROJECT_NAME has been set up with a basic directory structure and CMake config."
