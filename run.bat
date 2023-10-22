@echo OFF
cls
SET mypath=%~dp0
pushd %mypath%\TEMP\
{{{EXECUTABLE_NAME}}}.exe
popd