add_executable(feature-6 main.cpp)

target_compile_features(feature-6 PUBLIC cxx_std_11)
set_target_properties(feature-6 PROPERTIES CXX_EXTENSIONS OFF)