:: #=========================================================================#
::  #                                                                       #
::  #     Copyright 2024 Federico Lencina - GNU General Public License      #
::  #                                                                       #
::  #     This program is free software; you can redistribute it and/or     #
::  #    modify it under the terms of the GNU General Public License as     #
::  #    published by the Free Software Foundation; either version 3 of     #
::  #          the License, or at your option any later version.            #
::  #                                                                       #
::  #  This program is distributed in the hope that it will be useful, but  #
::  #       WITHOUT ANY WARRANTY; without even the implied warranty of      #
::  #          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.         #
::  #          See the GNU General Public License for more details.         #
::  #                                                                       #
::  #        You should have received a copy of the GNU General Public      #
::  #              License along with this program. If not, see             #
::  #                    <https://www.gnu.org/licenses/>.                   #
::  #                                                                       #
:: #=========================================================================#

@ECHO OFF

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /B
)

@ECHO ON

REM -Adult Content Filter- (WiFi) | Author: Federico Lencina | -<https://github.com/federicolencina>-
REM -Stable Version on: Windows 11 Version 23H2

@ECHO OFF

:main
ECHO  To set System Configuration to DISABLE ADULT CONTENT enter 'Y'
ECHO  To set System Configuration to Cloudflare DNS enter 'C'
:lap
ECHO  To set System's Default Configuration enter 'D'
:end
ECHO  To exit from the program enter 'E'

ECHO.
set /p dialVal= ">"
ECHO.


if /I "%dialVal%"== "y" (
    netsh interface ipv4 set dnsservers name="Wi-Fi" source=STATIC address=1.1.1.3 > nul 2>&1
    netsh interface ipv6 set dnsservers name="Wi-Fi" source= STATIC address=2606:4700:4700::1113 > nul 2>&1
    netsh interface ipv4 add dnsservers name="Wi-Fi" address=1.0.0.3 > nul 2>&1
    netsh interface ipv6 add dnsservers name="Wi-Fi" address=2606:4700:4700::1003 > nul 2>&1
    ipconfig /flushdns > nul

    ECHO System Configuration has been changed to: Adult Content Blocked.
    ECHO.
    goto :lap
) else if /I "%dialVal%"== "c" (
    netsh interface ipv4 set dnsservers name="Wi-Fi" source=STATIC address=1.1.1.1 > nul 2>&1
    netsh interface ipv6 set dnsservers name="Wi-Fi" source= STATIC address=2606:4700:4700::1111 > nul 2>&1
    netsh interface ipv4 add dnsservers name="Wi-Fi" address=1.0.0.1 > nul 2>&1
    netsh interface ipv6 add dnsservers name="Wi-Fi" address=2606:4700:4700::1001 > nul 2>&1
    ipconfig /flushdns > nul

    ECHO System Configuration has been changed to: Cloudflare DNS 1.1.1.1.
    ECHO.
    goto :lap
) else if /I "%dialVal%"== "d" (
    netsh interface ipv4 set dnsservers name="Wi-Fi" source=DHCP > nul 2>&1
    netsh interface ipv6 set dnsservers name="Wi-Fi" source=DHCP > nul 2>&1 
    netsh interface ipv4 add dnsservers name="Wi-Fi" address=DHCP > nul 2>&1
    netsh interface ipv6 add dnsservers name="Wi-Fi" address=DHCP > nul 2>&1
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
