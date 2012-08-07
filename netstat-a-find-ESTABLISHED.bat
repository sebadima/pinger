@echo off

%WINDIR%\system32\netstat.exe  /a  |  find "ESTABLISHED"                            
