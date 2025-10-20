add_executable(feature-5 main.cpp)

target_compile_features(feature-5 PUBLIC cxx_std_11)
set_target_properties(feature-5 PROPERTIES CXX_EXTENSIONS OFF)