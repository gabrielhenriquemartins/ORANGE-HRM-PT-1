@echo off
set "DIRECTORY=your-path-to-project"

call "%DIRECTORY%\tests\common\execution\windows_execution.bat" > "%DIRECTORY%\tests\common\execution\execution_log.txt" 2>&1

echo Saved logs in "%DIRECTORY%\tests\common\execution\execution_log.txt"
pause