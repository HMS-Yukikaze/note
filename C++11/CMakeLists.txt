cmake_minimum_required(VERSION 3.24)

#https://zh.cppreference.com/w/cpp/11
Project(cpp11 LANGUAGES CXX)

#auto & decltype
add_subdirectory(feature-1)

# = delete & = default
add_subdirectory(feature-2)

# chrono_literals
add_subdirectory(feature-3)

# range-based for loop
add_subdirectory(feature-4)

add_subdirectory(feature-5)

add_subdirectory(feature-6)

#add_subdirectory(feature-1)
