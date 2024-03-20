要在 Windows 上部署 TensorFlow-GPU，您需要执行以下步骤：

1. 安装 NVIDIA 显卡驱动程序
在使用 TensorFlow-GPU 之前，必须先安装与您的 NVIDIA 显卡兼容的驱动程序。您可以从 NVIDIA 官方网站下载驱动程序。

2. 安装 CUDA 工具包
TensorFlow-GPU 需要 CUDA 支持。您可以从 NVIDIA 官方网站下载适用于您的显卡的 CUDA 工具包。建议使用 TensorFlow 官方网站上推荐的 CUDA 版本。

3. 安装 cuDNN 库
cuDNN 库是 NVIDIA 的深度神经网络库。TensorFlow-GPU 需要 cuDNN 库来加速模型训练和推理。您可以从 NVIDIA 官方网站下载适用于您的 CUDA 版本和操作系统的 cuDNN 库。

4. 安装 Anaconda 或 Miniconda
您可以使用 Anaconda 或 Miniconda 管理 Python 环境。请从 Anaconda 或 Miniconda 官方网站下载适用于您的操作系统的安装程序。在安装 Anaconda 或 Miniconda 时，请确保勾选添加到 PATH 环境变量选项。

5. 创建 Python 虚拟环境
使用 Anaconda 或 Miniconda 创建 Python 虚拟环境。在虚拟环境中安装 TensorFlow-GPU 和其他必要的 Python 库。

6. 安装 TensorFlow-GPU
使用 conda 命令或 pip 命令在虚拟环境中安装 TensorFlow-GPU。TensorFlow-GPU 的安装命令如下：

```
conda install tensorflow-gpu
```

```
pip install tensorflow-gpu
```
测试 TensorFlow-GPU 安装
使用以下代码测试 TensorFlow-GPU 是否已正确安装：
```
//python

import tensorflow as tf
print(tf.test.is_gpu_available())
```
如果输出为 True，则 TensorFlow-GPU 已正确安装。




