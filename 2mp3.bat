@echo off
rem echo %~s1
rem echo %~n1
rem echo %~f1
rem echo %~dp1
rem goto exit

echo %~s1
echo %~n1
echo %~f1
echo %~dp1
echo "E:\Programs\ffmpeg-3.3.2-win64-static\bin\ffmpeg.exe"
echo %1
echo "%~f1.mp3"
rem goto exit
rem cls

"E:\Programs\ffmpeg-3.3.2-win64-static\bin\ffmpeg.exe" -y -i %1 "%~f1.mp3"
rem cls

echo ===============================
echo Mp3Ã·»°ÕÍ±œ£∫%~f1.mp3
echo ===============================
:exit
pause 