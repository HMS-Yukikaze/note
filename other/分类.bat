@echo off
setlocal enabledelayedexpansion

REM 设置工作路径，默认为当前路径
if "%~1" == "" (
    set "working_dir=%cd%"
) else (
    set "working_dir=%~1"
)
CHCP 65001 > NUL

REM 切换到工作路径
cd /d "%working_dir%"

REM 创建文件夹
mkdir images 2>nul
mkdir labels 2>nul
mkdir nolabels 2>nul

REM 处理图片文件
for %%i in (*.jpg *.jpeg *.png) do (
    REM 提取文件名和扩展名
    set "filename=%%~ni"
    set "extension=%%~xi"
    
    REM 构建标注文件名
    set "label_file=!filename!.txt"
    
    REM 检查是否存在同名标注文件
    if exist "!label_file!" (
        REM 移动图片文件和标注文件
        move "%%i" ".\images\%%i"
        move "!label_file!" ".\labels\!label_file!"
    ) else (
        REM 移动未标注的图片文件
        move "%%i" ".\nolabels\%%i"
    )
)

echo 操作完成。
pause
