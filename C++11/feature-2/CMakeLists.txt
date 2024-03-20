
add_executable(feature-2 main.cpp)

target_compile_features(feature-2 PUBLIC cxx_std_11)
set_target_properties(feature-2 PROPERTIES CXX_EXTENSIONS OFF)