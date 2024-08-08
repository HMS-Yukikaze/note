# mac开发笔记
1. bash和zsh的区别
   bash是Bourne-Again Shell的缩写，zsh是Z shell的缩写，两者都是类UNIX系统下的shell，zsh相比bash有很多改进，比如自动补全、命令别名、插件等。zsh的配置文件是.zshrc，而bash的配置文件是.bashrc。
2. 配置文件
   ### 系统配置文件
   | 配置文件 | 描述 |
   | --- | --- |
   | /etc/profile | 在登录系统时，每个用户都会执行一次。<br> 主要用于设置环境变量，如 PATH、USER 等，以及一些全局性的初始化工作。<br> 由于执行较早，通常放置一些系统级的配置 |
   ｜/etc/bashrc | 在每次打开一个新的 bash shell 时都会执行。<br> 主要用于设置别名、函数、命令提示符等，以及一些交互式的配置 |
   ｜/etc/zshrc | 与 bashrc 类似,如果系统默认 shell 为 zsh，则在每次打开一个新的 zsh shell 时都会执行  |
   | /etc/paths | 这个文件比较特殊，它包含了一个路径列表，用于系统在搜索可执行文件时参考 |
   | /etc/zprofile | 主要用于设置 zsh shell 的登录环境 |
    ### 用户配置文件
   | 配置文件 | 描述 |
   | --- | --- |
   | ~/.bash_profile | 主要用于设置用户的环境变量、别名、函数等<br> 可以覆盖 /etc/profile 中的设置 |
   | ~/.zshrc | 主要用于设置用户的 zsh 配置<br> 可以覆盖 /etc/zshrc 中的设置 |
   | ~/.bashrc | 主要用于设置用户的 bash 配置<br> 可以覆盖 /etc/bashrc 中的设置 |
   | ~/.zprofile | 主要用于设置用户的 zsh 登录环境 |

    ### 总结
      - 系统配置文件 影响所有用户，设置全局环境。
      - 用户配置文件 影响单个用户，设置个性化环境。
      - profile 和 zprofile 主要用于登录时的设置。
      - bashrc 和 zshrc 主要用于交互式 shell 的设置。
      - paths 文件用于指定系统搜索可执行文件的路径。
      - 优先级：用户配置文件 > 系统配置文件 > 全局配置文件。
3. c++开发环境搭建
   ### 下载安装vscode
   下载地址：https://code.visualstudio.com/download
   ### 安装Homebrew
   打开终端，输入以下命令安装Homebrew：
   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
   ```
   ### 安装c++编译环境
   ```
   brew install gcc
   ```
   ### 安装cmake
   ```
   brew install cmake ninja
   ```
   ### 安装llvm
   ```
   brew install llvm
   ```
   ### 安装pkg-config
   ```
   brew install pkg-config
   ``` 

   ### vscode 扩展
   - C/C++插件
   - CMake Tools插件
   - CodeLLDB 
   - Doxygen Documentation Generator
  ### 插件设置
  1. cmake tools插件设置
     - 点击左侧菜单栏的CMake Tools，选择设置按钮
     - 选择cmake：anditional compiler search Dirs，添加`/opt/homebrew/opt/llvm/bin/`
