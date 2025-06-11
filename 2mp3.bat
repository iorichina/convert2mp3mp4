@echo off
chcp 65001
echo [调试] 设置代码页为UTF-8
echo [调试] 脚本开始执行

setlocal enabledelayedexpansion
echo [调试] 启用延迟扩展

echo [调试] 当前目录: %CD%
echo [调试] 脚本路径: %~dp0
echo [调试] 完整命令行: %0 %*
echo.

echo [调试] "%%1=%1"
echo [调试] "%%~1=%~1"
echo [调试] "%%~s1=%~s1"
echo [调试] "%%~n1=%~n1"
echo [调试] "%%~f1=%~f1"
echo [调试] "%%~x1=%~x1"
echo.

if "%~1"=="" (
    echo 请将文件夹拖动到本脚本图标上运行。
    pause
    exit /b 1
)

echo [调试] 准备检查文件是否存在: "%~1"
set "FILE_PATH=%~1"
echo [调试] 处理后的路径: "!FILE_PATH!"

if not exist "!FILE_PATH!" (
    echo [错误] 文件不存在：!FILE_PATH!
    echo 按任意键退出...
    pause
    exit /b 1
)
echo [调试] 文件存在检查通过
echo.

echo [调试] 检查ffmpeg配置文件是否存在

if not exist "%~dp0ffmpeg_path.txt" (
    echo [错误] 找不到ffmpeg配置文件：%~dp0ffmpeg_path.txt
    pause
    exit /b 1
)
echo [调试] 配置文件存在检查通过
echo.

echo [调试] 读取ffmpeg路径...

for /f "usebackq delims=" %%i in ("%~dp0ffmpeg_path.txt") do (
    set "FFMPEG_PATH=%%i"
    echo [调试] 成功读取FFMPEG路径
)
echo [调试] "FFMPEG_PATH=%FFMPEG_PATH%"
echo.

echo [调试] 检查ffmpeg是否存在

if not exist "%FFMPEG_PATH%" (
    echo [错误] 找不到ffmpeg程序：%FFMPEG_PATH%
    echo 请检查ffmpeg_path.txt中的路径是否正确
    pause
    exit /b 1
)
echo [调试] ffmpeg程序检查通过
echo.

set "file_ext=%~x1"
echo [调试] 检查文件类型： "%file_ext%"

if /i "%file_ext%"==".mp3" (
    echo [信息] 文件已经是MP3格式，跳过转换：%~1
) else (
    echo [信息] 文件需要转换为MP3格式
    echo [调试] 准备执行命令: "%FFMPEG_PATH%" -y -i "%~1" "%~f1.mp3"

    "%FFMPEG_PATH%" -y -i "%~1" "%~f1.mp3"

    if !errorlevel! equ 0 (
        echo [成功] 转换完成：%~f1.mp3
    ) else (
        echo [错误] 转换失败，错误代码：!errorlevel!
        pause
        exit /b 1
    )
)

echo.
echo [信息] 处理完成。
pause
exit /b 0 