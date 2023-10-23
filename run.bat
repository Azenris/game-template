@echo OFF
cls
SET mypath=%~dp0
pushd %mypath%\TEMP\
__GAME_TEMPLATE_NAME__.exe
popd