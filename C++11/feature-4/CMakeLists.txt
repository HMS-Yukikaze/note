add_executable(feature-4 main.cpp)

target_compile_features(feature-4 PUBLIC cxx_std_11)
set_target_properties(feature-4 PROPERTIES CXX_EXTENSIONS OFF)