@echo off
chcp 65001
setlocal enabledelayedexpansion

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

echo [调试] 检查ffmpeg配置文件是否存在

if not exist "%~dp0ffmpeg_path.txt" (
    echo [错误] 找不到ffmpeg配置文件：%~dp0ffmpeg_path.txt
    pause
    exit /b 1
)
echo [调试] 配置文件存在检查通过
echo.

for /f "usebackq delims=" %%i in ("%~dp0ffmpeg_path.txt") do set "FFMPEG_PATH=%%i"
echo "FFMPEG_PATH=%FFMPEG_PATH%"

echo [调试] 检查ffmpeg是否存在

if not exist "%FFMPEG_PATH%" (
    echo [错误] 找不到ffmpeg程序：%FFMPEG_PATH%
    echo 请检查ffmpeg_path.txt中的路径是否正确
    pause
    exit /b 1
)
echo [调试] ffmpeg程序检查通过
echo.

cd /d "%~f1"
echo ===============================
for %%s in (.,*) do (
  if not "." == "%%s" (
    set "ext=%%~xs"
    echo [调试] 获取文件扩展名 "!ext!"
    
    echo [调试] 如果不是avi文件才进行转换
    if /i not "!ext!"==".avi" (
      echo 正在转换: %%s
      "%FFMPEG_PATH%" -y -i "%%s" "%%s.avi"
      echo Avi转换完毕：%~f1\%%s.avi
    ) else (
      echo 跳过AVI文件: %%s
    )
    echo ===============================
  )
)

pause