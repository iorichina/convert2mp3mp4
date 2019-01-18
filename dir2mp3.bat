@echo off
rem echo 正在运行的这个批处理：
rem echo 完全路径：%0
rem echo 去掉引号：%~0
rem echo 所在分区：%~d0
rem echo 所处路径：%~p0
rem echo 文件名：%~n0
rem echo 扩展名：%~x0
rem echo 文件属性：%~a0
rem echo 修改时间：%~t0
rem echo 文件大小：%~z0
rem echo %~s1
rem echo %~n1
rem echo %~f1
rem echo %~dp1
rem goto exit

echo "%%~s1=%~s1"
echo "%%~n1=%~n1"
echo "%%~f1=%~f1"
echo "%%~dp1=%~dp1"
echo "E:\Programs\ffmpeg-3.3.2-win64-static\bin\ffmpeg.exe"
echo "%%1=%1"

rem goto exit
rem cls

cd %~f1
echo ===============================
for %%s in (.,*) do (
  if not "." == "%%s" (
    echo %%s
	"E:\Programs\ffmpeg-3.3.2-win64-static\bin\ffmpeg.exe" -y -i "%%s" "%%s.mp3"
    echo Mp3提取完毕：%~f1\%%s.mp3
    echo ===============================
  )
)

rem cls

:exit
pause