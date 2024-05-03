@ECHO OFF

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /B
)

@ECHO ON

REM -Adult Content Filter- (WiFi) | Author: Federico Lencina | -<https://github.com/fedelensch>-
REM -Stable Version on: Windows 11 Version 23H2

@ECHO OFF

:main
ECHO  To set System Configuration to DISABLE ADULT CONTENT enter 'Y'
ECHO  To set System Configuration to Cloudflare DNS enter 'C'
:lap
ECHO  To set Default System Configuration enter 'D'
:end
ECHO  To exit from the program enter 'E'

ECHO.
set /p dialVal= ">"
ECHO.


if /I "%dialVal%"== "y" (
    netsh interface ipv4 set dnsservers name="Ethernet" source=STATIC address=1.1.1.3 > nul 2>&1
    netsh interface ipv6 set dnsservers name="Ethernet" source= STATIC address=2606:4700:4700::1113 > nul 2>&1
    netsh interface ipv4 add dnsservers name="Ethernet" address=1.0.0.3 > nul 2>&1
    netsh interface ipv6 add dnsservers name="Ethernet" address=2606:4700:4700::1003 > nul 2>&1
    ipconfig /flushdns > nul

    ECHO System Configuration has been changed to: Adult Content Blocked.
    ECHO.
    goto :lap
) else if /I "%dialVal%"== "c" (
    netsh interface ipv4 set dnsservers name="Ethernet" source=STATIC address=1.1.1.1 > nul 2>&1
    netsh interface ipv6 set dnsservers name="Ethernet" source= STATIC address=2606:4700:4700::1111 > nul 2>&1
    netsh interface ipv4 add dnsservers name="Ethernet" address=1.0.0.1 > nul 2>&1
    netsh interface ipv6 add dnsservers name="Ethernet" address=2606:4700:4700::1001 > nul 2>&1
    ipconfig /flushdns > nul

    ECHO System Configuration has been changed to: Cloudflare DNS 1.1.1.1.
    ECHO.
    goto :lap
) else if /I "%dialVal%"== "d" (
    netsh interface ipv4 set dnsservers name="Ethernet" source=DHCP > nul 2>&1
    netsh interface ipv6 set dnsservers name="Ethernet" source=DHCP > nul 2>&1 
    netsh interface ipv4 add dnsservers name="Ethernet" address=DHCP > nul 2>&1
    netsh interface ipv6 add dnsservers name="Ethernet" address=DHCP > nul 2>&1
    ipconfig /flushdns > nul
    
    ECHO System Configuration has been changed to: System's Default Configuration.
    ECHO.
    goto :end
) else if /I "%dialVal%"== "e" (
    exit
) else (
    ECHO.
    ECHO Option not found, try again...
    goto :main
)
