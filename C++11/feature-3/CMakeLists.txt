add_executable(feature-3 main.cpp)

target_compile_features(feature-3 PUBLIC cxx_std_11)
set_target_properties(feature-3 PROPERTIES CXX_EXTENSIONS OFF)