1.在vscode中安装C/C++插件
2.在vscode中安装C++ Compile Run插件
3.打开vscode，在文件菜单中选择首选项->设置，打开设置窗口
4.在设置窗口中的搜索框中输入"C++ Compile Run"，找到"C++ Compile Run: Compiler Path"选项
5.点击"Edit in settings.json"按钮，打开settings.json文件
6.在settings.json文件中找到"C++ Compile Run: Compiler Path"选项，并设置为MSVC编译器的路径，例如"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64\cl.exe"
7.保存settings.json文件，完成c++ MSVC开发环境的配置。

C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.29.30133\bin\Hostx64\x86

”Hostx64\x86“，前者代表编译器工具集运行所在的平台，后者代表编译器build应用程序，应用程序所要运行的目标平台
Hostx64是本机的x64编译器
Hostx86是本机x86编译器
进入Hostx64，里面有4种目标平台

所有运行在X64主机下的编译器的目录名为"hostx64",
在这个目录下面的子目录文件名x64,x86代表着目标架构

https://www.cnblogs.com/feipeng8848/p/14306384.html