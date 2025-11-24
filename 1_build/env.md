根据你提供的历史记录，我整理出一个从下载 Boost 源码到构建安装的完整流程（假设在 Ubuntu 系统上）：

---

### 1. 安装依赖

```bash
sudo apt update
sudo apt install libboost-all-dev git cmake build-essential -y
```

> 这里 `libboost-all-dev` 是系统默认的 Boost 库，通常用于开发依赖；如果你是要从源码编译最新版本，可以用作依赖检测。

---

### 2. 克隆 Boost 源码并切换版本

```bash
git clone https://github.com/boostorg/boost.git
cd boost
git checkout boost-1.89.0
```

---

### 3. 初始化子模块

Boost 各模块是独立仓库，通过 submodule 管理：

```bash
git submodule update --init --recursive --force
```

---

### 4. 创建构建目录（推荐和源码分离）

```bash
cmake -S . -B build
```

* `-S .` 指定源码目录
* `-B build` 指定构建目录

---

### 5. 编译 Boost

```bash
cmake --build build -j8
```

* `-j8` 使用 8 个线程并行编译，可根据 CPU 核心数调整

---

### 6. 安装 Boost

```bash
sudo cmake --build build --target install
```

> 使用 `sudo` 将 Boost 安装到系统默认路径（通常 `/usr/local`）

---

### 7. 验证安装

```bash
ls /usr/local/lib/cmake/Boost-1.89.0
```


