cmake_minimum_required(VERSION 3.18)

# 如果你是不同显卡，请设置为显卡对应的号码参考这里：https://developer.nvidia.com/zh-cn/cuda-gpus#compute
#set(CUDA_GEN_CODE "-gencode=arch=compute_75,code=sm_75")

project(CUDALearn LANGUAGES CXX CUDA)
# 设置 C++ 和 CUDA 标准
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CUDA_STANDARD 11)

set(CUDA_NVCC_FLAGS "${CUDA_NVCC_FLAGS} -arch=sm_75")


#if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
#  set(CMAKE_CUDA_ARCHITECTURES 75)
#endif()

# 添加源文件
set(SOURCES
    main.cpp
    hello.cu
    hello.cuh
)


add_executable(out ${SOURCES})

set_target_properties(out PROPERTIES
        CUDA_ARCHITECTURES native
        CUDA_STANDARD 17
        CUDA_STANDARD_REQUIRED ON
        CXX_STANDARD 17
        CXX_STANDARD_REQUIRED ON
        CUDA_ARCHITECTURES "75"
)
#set_target_properties(out PROPERTIES CUDA_ARCHITECTURES "75")
target_compile_features(out PUBLIC cxx_std_17)
set_target_properties(out PROPERTIES CXX_EXTENSIONS OFF)
# Specify the output directory for CUDA files (optional)
#set(CUDA_SEPARABLE_COMPILATION ON)
#set(CMAKE_CUDA_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/cuda)