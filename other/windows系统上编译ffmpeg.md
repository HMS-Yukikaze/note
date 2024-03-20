## **准备安装环境**
    1. 安装mingw-64/msys2
    2. cmake
    3. ffmpeg源码，x264源码，x265源码(微软ffmpeg地址:https://github.com/Microsoft/FFmpegInterop)
## **安装mingw-64/msys2编译环境**
    1. 更新所有包
        `pacman -Syu`
    2. 安装基础工具
        `pacman -S mingw-w64-x86_64-toolchain`
    3. 安装其他工具
        `pacman -S yasm
         pacman -S nasm
         pacman -S make`
## 整理文件目录
+ FFMPEG
    + ffmpeg-source
    + x264  
    + x265  

## 命令行相关  
```  
#进入msys2安装目录  
d:  
cd  d:\msys64  

#如果要打开msys2的mingw64窗口  
msys2_shell.cmd -mingw64  

#如果要打开msys2的msys窗口  
#msys2_shell.cmd  
```


## + **编译x264**
  1. 打开mingw64，进入x264目录  
  2. 新建**mbuild.sh**,输入:  
    ``` 
    #!/bin/bash    
    # Set paths to x264 and x265    
    X264_PATH="/f/FFmpegBuild/x264/build/lib/pkgconfig/"    
    X265_PATH="/f/FFmpegBuild/x265/install/lib/pkgconfig/"  
        export PKG_CONFIG_PATH=$X264_PATH:$X265_PATH:$PKG_CONFIG_PATH  
        # Configure FFmpeg with x264 and x265   
        ./configure --enable-gpl --enable-libx264 --enable-libx265 --disable-static --enable-shared --prefix=/f/FFmpegBuild/install    
        # Build FFmpeg   
        make -j8    
        # Install FFmpeg    
        make install
    ```

## + **编译x265**
1. 打开mingw64，安装nasm，若已安装，则忽略此步骤
    `pacam -S  pacman -S mingw-w64-x86_64-nasm`
2. 打开cmake GUI，设置好source和build路径，点击configure，成功后，点击generate，显示成功后打开sln。  
3. 若要通过mingw64链接x265,进入生成路径下的`/lib/pkgconfig/`目录，编辑`x265.pc`,将其中的**prefix**路径改成Linux下的格式。

## NOTE（踩坑记录)    
1. 缺少nasm:  
    `pacam -S  pacman -S mingw-w64-x86_64-nasm`  
2. 在windows中使用cmake时由于存在git的环境变量导致cmake报错"list GET given empty list";  
    `去除git环境变量后,重启cmake，清除cache，重新configure，成功编译。`    

## + **编译ffmpeg**
