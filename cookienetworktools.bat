REM made by cookie for fun and ease of use...
:startup
@echo OFF
title Cookie Network Scripts

rem CHECKS TO SEE IF YOU HAVE RUN AS ADMIN, SCRIPT WILL CLOSE IF NOT RAN AS ADMIN. SOME COMMANDS MIGHT FAIL, REMOVE THIS IF YOU DONT WANT THIS CHECK.
net.exe session 1>NUL 2>NUL || (Echo This script requires elevated rights. & Pause >NUL & Exit)


:main
color 06
cls
echo Options:
echo.
echo 1. Reverse SSH tunnel
echo 2. Socks Proxy
echo 3. Ping Test
echo 4. IP info
echo 5. nslookup
echo 6. msconfig
echo 7. Device Manager
echo 8. SFC checker
echo 9. DISM repair
echo a. powercheck
echo b. System Info
echo x. Exit

set /p input=": "

if %input%==1 goto one
if %input%==2 goto two
if %input%==3 goto ping
if %input%==4 goto ipinfo
if %input%==5 goto lookup
if %input%==6 goto msconfig
if %input%==7 goto device
if %input%==8 goto sfc
if %input%==9 goto dism
if %input%==a goto powercheck
if %input%==b goto sysinfo
if %input%==x goto x


REM checks to see if invalid input is provided.
:error
cls
color 0d
title you fucked up.
cls
echo How did you fuck up a 3 option thing? only enter 1, 2, or x?
pause >NUL
goto main


:one
cls
color 0a
title Cookie Network Scripts [Reverse SSH Tunnel]
cls
set /p unblockport="Port that is unblocked: "
set /p blockedport="Port that is being blocked: "
set /p sship="IP of your SSH server "
set /p user="Username of your server "
cls
echo Server Connection is being attempted...
echo IF you see nothing after this, youre probably connected.
call ssh -N -R %unblockport%:localhost:%blockedport% %user%@%sship%
goto main


:two
cls
color 04
title Cookie Network Scripts [Socks Proxy]
echo Press 1 to autoconnect to cookie house
echo Press 2 to custom enter ip / Port
echo Press x to goto main
set /p i="Selection: "
if %i%==1 goto auto
if %i%==2 goto custom
if %i%==x goto main
goto main
:auto
cls
echo SOCKS proxy open on localhost:8080
call ssh -N -D 8080 <INSERT IP/PORT OF SSH SERVER>
goto main

:custom
cls
set /p sship="IP of your SSH server "
set /p user="Username of your server "
set /p port="Socks Port "
echo Created SOCKS proxy on localhost port %port%
call ssh -N -D %port% %user%@%sship%
goto main

:x
Exit


:ping
cls
REM GETS local ip & Default Gateway
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set NetworkIP=%%a
for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do set dg=%%~a
cls


call ping 127.0.0.1
call ping %NetworkIP%
call ping %dg%
call ping 8.8.8.8
call ping 1.1.1.1
call ping google.com
call ping www.hogwartslegacy.com
pause >NUL
goto main


:ipinfo
cls
ipconfig /all

echo.

echo 1: Release / Renew IP
echo 2. Flush DNS
echo 3. Main Menu


set /p id="Selection: "
if %id%==1 goto rip
if %id%==2 goto flush
if %id%==3 goto main
goto main


:rip
cls
call ipconfig /release
call ipconfig /renew
cls
goto ipinfo


:flush
cls 
call ipconfig /flushdns
echo flushed..
pause >NUL
goto ipinfo


:lookup
cls
echo Domain name / Ip of lookup
set /p ipaddr="IP/Domain: "
nslookup %ipaddr%
pause >NUL
goto main


:msconfig
cls
call msconfig
goto main


:device
cls
call devmgmt.msc
goto main


:sfc
cls
call SFC /scannow
pause >NUL
goto main


:dism
cls
call DISM /Online /Cleanup-Image /RestoreHealth
pause >NUL
goto main


:powercheck
cls
call powercfg/energy
pause >NUL
goto main


:sysinfo
cls
call systeminfo
pause >NUL
goto main