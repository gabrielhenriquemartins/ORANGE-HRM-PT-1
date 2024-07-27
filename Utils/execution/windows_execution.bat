@echo off
echo This is the Orange Pipeline being executed

set DIRECTORY=your-path-to-project
set "processName=Docker Desktop.exe"
set "dockerPath=your-path-to-docker-desktop"

start powershell -command "& {Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('The Robot Test Script is Running! Wait a few minutes and check the execution log!', 'Warning', 'OK', 'Information')}"

echo.
tasklist /FI "IMAGENAME eq %processName%" | find /I "%processName%" > nul

if errorlevel 1 (
    echo Docker desktop is being initiated ...
    start "" "%dockerPath%\Docker Desktop.exe"
	timeout /t 60
) else (
    echo Docker desktop is already running ...
)
echo.

cd %DIRECTORY%\Metrics

echo.
echo *****************************
echo STEP 1: Removing all containers ... 
echo *****************************
docker-compose down -v

echo.
echo *****************************
echo STEP 2: Running all containers ...
echo *****************************
docker-compose up -d

echo. 
echo *****************************
echo STEP 3: Running the robot script ...
echo *****************************
cd %DIRECTORY%
docker container run -it --rm -v "%DIRECTORY%/Docs:/opt/robotframework/Docs" -v "%DIRECTORY%/Tests:/opt/robotframework/Tests" -v "%DIRECTORY%/Resources:/opt/robotframework/Resources" -v "%DIRECTORY%/Utils:/opt/robotframework/Utils" -v "%DIRECTORY%/Results:/opt/robotframework/Results"  robot  bash -c "/opt/robotframework/Utils/create_folder.sh  &&   /opt/robotframework/Utils/execute_robot.sh;    /opt/robotframework/Utils/rename_video.sh;   libtoc --output_dir /opt/robotframework/Docs/Library --toc_file output.html /opt/robotframework/Resources"

echo. 
echo *****************************
echo STEP 4: Restore Grafana Dashboard
echo *****************************
python %DIRECTORY%\Metrics\backups\restore_grafana_and_influxdb.py
echo. 

echo. 
echo *****************************
echo STEP 5: Executing the script to populate the InfluxDB
echo *****************************
python %DIRECTORY%\Utils\server.py

echo. 
echo *****************************
echo STEP 6: Creating the Grafana and InfluxDB Backup
echo *****************************
python %DIRECTORY%\Metrics\backups\backup_grafana_and_influxdb.py
echo. 

start powershell -command "& {Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('The execution has finished!', 'Warning', 'OK', 'Information')}"

echo The execution finished! Check the log file ...
pause
