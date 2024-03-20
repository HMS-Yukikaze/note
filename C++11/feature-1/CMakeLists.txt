
add_executable(feature-1 main.cpp)

target_compile_features(feature-1 PUBLIC cxx_std_11)
set_target_properties(feature-1 PROPERTIES CXX_EXTENSIONS OFF)