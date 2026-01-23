# C++ CUDA Toolset 安装指南

## 1. 系统要求

### 1.1 支持的操作系统
- Windows 10/11 (64-bit)
- Linux (Ubuntu 18.04+, CentOS 7+, RHEL 7+)
- macOS (仅支持 CUDA 10.2 及更早版本)

### 1.2 硬件要求
- NVIDIA GPU（计算能力 3.5 或更高）
- 查看 GPU 计算能力：[NVIDIA GPU 列表](https://developer.nvidia.com/cuda-gpus)

### 1.3 软件要求
- GCC/G++ 编译器（Linux）
- Visual Studio 2017/2019/2022（Windows）
- CMake 3.18+（推荐）

## 2. 安装 CUDA Toolkit

### 2.1 Windows 安装

#### 步骤 1: 下载 CUDA Toolkit
访问 [NVIDIA CUDA 下载页面](https://developer.nvidia.com/cuda-downloads)

选择：
- Operating System: Windows
- Architecture: x86_64
- Version: 10/11
- Installer Type: exe (local) 推荐

#### 步骤 2: 安装 CUDA
```powershell
# 运行下载的安装程序
cuda_12.x.x_windows.exe

# 选择自定义安装，确保勾选：
# - CUDA Toolkit
# - CUDA Samples
# - CUDA Documentation
# - CUDA Visual Studio Integration
```

#### 步骤 3: 验证安装
```powershell
# 检查 CUDA 版本
nvcc --version

# 检查 NVIDIA 驱动
nvidia-smi
```

#### 步骤 4: 配置环境变量
通常安装程序会自动配置，手动检查：
```
CUDA_PATH = C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.x
Path 中包含：
  - %CUDA_PATH%\bin
  - %CUDA_PATH%\libnvvp
```

### 2.2 Linux (Ubuntu) 安装

#### 步骤 1: 移除旧版本（如果存在）
```bash
sudo apt-get --purge remove "*cuda*" "*cublas*" "*cufft*" "*cufile*" "*curand*" \
 "*cusolver*" "*cusparse*" "*gds-tools*" "*npp*" "*nvjpeg*" "nsight*" "*nvvm*"
sudo apt-get autoremove
```

#### 步骤 2: 安装依赖
```bash
sudo apt-get update
sudo apt-get install -y build-essential
sudo apt-get install -y gcc g++ make
```

#### 步骤 3: 下载并安装 CUDA
```bash
# 下载 CUDA 仓库包
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb

# 更新并安装
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-6

# 或安装特定版本
sudo apt-get -y install cuda-toolkit-11-8
```

#### 步骤 4: 配置环境变量
```bash
# 编辑 ~/.bashrc 或 ~/.zshrc
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
```

#### 步骤 5: 验证安装
```bash
nvcc --version
nvidia-smi
```

### 2.3 macOS 安装

注意：CUDA 在 macOS 上的支持已停止（最后支持版本为 10.2）

```bash
# 下载 CUDA 10.2 for macOS
# 从 NVIDIA 官网下载 .dmg 文件并安装

# 配置环境变量
echo 'export PATH=/Developer/NVIDIA/CUDA-10.2/bin:$PATH' >> ~/.zshrc
echo 'export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-10.2/lib:$DYLD_LIBRARY_PATH' >> ~/.zshrc
source ~/.zshrc
``` 


## 3. 安装 cuDNN

cuDNN (CUDA Deep Neural Network library) 是深度学习加速库，YOLO 等框架需要。

### 3.1 下载 cuDNN

1. 访问 [NVIDIA cuDNN 下载页面](https://developer.nvidia.com/cudnn)
2. 注册/登录 NVIDIA 开发者账号
3. 选择与 CUDA 版本匹配的 cuDNN 版本

### 3.2 Windows 安装

```powershell
# 1. 解压下载的 cuDNN zip 文件
# 2. 复制文件到 CUDA 目录

# 复制 bin 文件
copy cudnn-*-archive\bin\*.dll "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.x\bin\"

# 复制 include 文件
copy cudnn-*-archive\include\*.h "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.x\include\"

# 复制 lib 文件
copy cudnn-*-archive\lib\x64\*.lib "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.x\lib\x64\"
```

### 3.3 Linux 安装

```bash
# 方法 1: 使用 tar 文件
tar -xvf cudnn-linux-x86_64-8.x.x.x_cudaX.Y-archive.tar.xz

sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*

# 方法 2: 使用 deb 包（推荐）
sudo dpkg -i cudnn-local-repo-ubuntu2204-8.x.x.x_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-*/cudnn-local-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get install libcudnn8 libcudnn8-dev
```

### 3.4 验证 cuDNN 安装

```bash
# 检查 cuDNN 版本
cat /usr/local/cuda/include/cudnn_version.h | grep CUDNN_MAJOR -A 2

# 或使用 Python
python3 -c "import torch; print(torch.backends.cudnn.version())"
```

## 4. 安装 TensorRT（可选，用于推理加速）

### 4.1 下载 TensorRT

访问 [NVIDIA TensorRT 下载页面](https://developer.nvidia.com/tensorrt)

### 4.2 Linux 安装

```bash
# 使用 tar 包安装
tar -xzvf TensorRT-8.x.x.x.Linux.x86_64-gnu.cuda-12.x.tar.gz
cd TensorRT-8.x.x.x

# 配置环境变量
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/TensorRT-8.x.x.x/lib' >> ~/.bashrc
source ~/.bashrc

# 安装 Python 包
cd TensorRT-8.x.x.x/python
pip install tensorrt-8.x.x.x-cp310-none-linux_x86_64.whl

# 安装 UFF（可选）
cd ../uff
pip install uff-0.6.9-py2.py3-none-any.whl

# 安装 graphsurgeon（可选）
cd ../graphsurgeon
pip install graphsurgeon-0.4.6-py2.py3-none-any.whl
```

### 4.3 Windows 安装

```powershell
# 1. 解压 TensorRT zip 文件到 C:\TensorRT-8.x.x.x

# 2. 添加到系统 Path
# C:\TensorRT-8.x.x.x\lib

# 3. 安装 Python 包
cd C:\TensorRT-8.x.x.x\python
pip install tensorrt-8.x.x.x-cp310-none-win_amd64.whl
```

## 5. C++ 项目配置

### gpu架构

### 5.1 CMake 配置示例

```cmake
cmake_minimum_required(VERSION 3.18)
project(YoloCuda LANGUAGES CXX CUDA)

# 设置 C++ 标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 17)

# 查找 CUDA
find_package(CUDA REQUIRED)
include_directories(${CUDA_INCLUDE_DIRS})

# 查找 cuDNN
set(CUDNN_ROOT_DIR "/usr/local/cuda")
find_path(CUDNN_INCLUDE_DIR cudnn.h
    HINTS ${CUDNN_ROOT_DIR}
    PATH_SUFFIXES include)
find_library(CUDNN_LIBRARY cudnn
    HINTS ${CUDNN_ROOT_DIR}
    PATH_SUFFIXES lib64 lib)

# 设置 CUDA 架构
set(CMAKE_CUDA_ARCHITECTURES 75 80 86 89)  # 根据你的 GPU 调整

# 添加可执行文件
add_executable(yolo_inference main.cpp inference.cu)

# 链接库
target_link_libraries(yolo_inference
    ${CUDA_LIBRARIES}
    ${CUDNN_LIBRARY}
    cudart
    cublas
)

# 设置 CUDA 编译选项
set_target_properties(yolo_inference PROPERTIES
    CUDA_SEPARABLE_COMPILATION ON
    CUDA_RESOLVE_DEVICE_SYMBOLS ON
)
```

### 5.2 Visual Studio 配置

#### 项目属性设置：

1. **配置类型**：应用程序 (.exe)

2. **CUDA C/C++** → **Device**：
   - Code Generation: `compute_75,sm_75;compute_80,sm_80;compute_86,sm_86`

3. **VC++ 目录**：
   - 包含目录：`$(CUDA_PATH)\include`
   - 库目录：`$(CUDA_PATH)\lib\x64`

4. **链接器** → **输入**：
   - 附加依赖项：`cudart.lib;cublas.lib;cudnn.lib`

### 5.3 简单的 CUDA 测试程序

```cpp
// test_cuda.cu
#include <iostream>
#include <cuda_runtime.h>

__global__ void helloFromGPU() {
    printf("Hello from GPU thread %d!\n", threadIdx.x);
}

int main() {
    // 检查 CUDA 设备
    int deviceCount;
    cudaGetDeviceCount(&deviceCount);
    std::cout << "CUDA Devices: " << deviceCount << std::endl;

    if (deviceCount > 0) {
        cudaDeviceProp prop;
        cudaGetDeviceProperties(&prop, 0);
        std::cout << "Device Name: " << prop.name << std::endl;
        std::cout << "Compute Capability: " << prop.major << "." << prop.minor << std::endl;
        std::cout << "Total Global Memory: " << prop.totalGlobalMem / (1024*1024) << " MB" << std::endl;
    }

    // 运行简单的 kernel
    helloFromGPU<<<1, 10>>>();
    cudaDeviceSynchronize();

    return 0;
}
```

编译：
```bash
# Linux/macOS
nvcc test_cuda.cu -o test_cuda
./test_cuda

# Windows
nvcc test_cuda.cu -o test_cuda.exe
test_cuda.exe
```

## 6. 常见问题

### 6.1 CUDA 版本不匹配

错误：`CUDA driver version is insufficient for CUDA runtime version`

解决：
```bash
# 更新 NVIDIA 驱动
# Ubuntu
sudo ubuntu-drivers autoinstall

# 或手动下载驱动
# https://www.nvidia.com/Download/index.aspx
```

### 6.2 找不到 CUDA 库

错误：`cannot find -lcudart`

解决：
```bash
# 检查环境变量
echo $LD_LIBRARY_PATH

# 添加 CUDA 库路径
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

### 6.3 cuDNN 版本不兼容

错误：`cuDNN version mismatch`

解决：
- 确保 cuDNN 版本与 CUDA 版本匹配
- 查看兼容性矩阵：[cuDNN Support Matrix](https://docs.nvidia.com/deeplearning/cudnn/support-matrix/index.html)

### 6.4 编译时找不到头文件

错误：`fatal error: cuda_runtime.h: No such file or directory`

解决：
```bash
# 检查 CUDA 安装路径
ls /usr/local/cuda/include/

# 在 CMakeLists.txt 中添加
include_directories(/usr/local/cuda/include)
```

## 7. 版本兼容性参考

### 7.1 CUDA 与 GPU 驱动版本对应

| CUDA 版本 | 最低驱动版本 (Linux) | 最低驱动版本 (Windows) |
|-----------|---------------------|----------------------|
| 12.6      | 560.28.03           | 560.76               |
| 12.4      | 550.54.15           | 551.78               |
| 12.2      | 535.54.03           | 536.25               |
| 12.0      | 525.60.13           | 527.41               |
| 11.8      | 520.61.05           | 522.06               |

### 7.2 PyTorch/TensorFlow 与 CUDA 版本

| 框架版本 | CUDA 11.8 | CUDA 12.1 | CUDA 12.4 |
|---------|-----------|-----------|-----------|
| PyTorch 2.5 | ✓ | ✓ | ✓ |
| PyTorch 2.4 | ✓ | ✓ | ✓ |
| TensorFlow 2.17 | ✓ | ✓ | - |
| TensorFlow 2.16 | ✓ | ✓ | - |

## 8. 性能测试

### 8.1 CUDA 带宽测试

```bash
# 运行 CUDA 示例程序
cd /usr/local/cuda/samples/1_Utilities/bandwidthTest
make
./bandwidthTest
```

### 8.2 cuDNN 性能测试

```bash
# 下载并编译 cuDNN 示例
git clone https://github.com/NVIDIA/cudnn-frontend.git
cd cudnn-frontend/samples
mkdir build && cd build
cmake ..
make
./conv_sample
```

## 9. 参考资源

- [CUDA Toolkit 文档](https://docs.nvidia.com/cuda/)
- [cuDNN 文档](https://docs.nvidia.com/deeplearning/cudnn/)
- [TensorRT 文档](https://docs.nvidia.com/deeplearning/tensorrt/)
- [CUDA 编程指南](https://docs.nvidia.com/cuda/cuda-c-programming-guide/)
- [CUDA 最佳实践](https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/)

## 10. 下一步

安装完成后，你可以：
1. 编译并运行 CUDA 示例程序
2. 配置深度学习框架（PyTorch, TensorFlow）
3. 开始 YOLO 模型的 GPU 加速训练和推理
4. 使用 TensorRT 优化模型推理性能
