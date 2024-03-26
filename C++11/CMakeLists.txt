cmake_minimum_required(VERSION 3.24)

#https://zh.cppreference.com/w/cpp/11
Project(cpp11 LANGUAGES CXX)

#auto & decltype
add_subdirectory(feature-1)

# = delete & = default
add_subdirectory(feature-2)

add_subdirectory(feature-3)

#add_subdirectory(feature-1)

#add_subdirectory(feature-1)
