@echo OFF
tools\timer.exe start

cls

:: Automatically runs C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat
if NOT defined VSCMD_ARG_TGT_ARCH (
	call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
)

:: MUST be after the enviroment setup
SETLOCAL EnableDelayedExpansion

SET debugMode=1
SET platform=PLATFORM_WINDOWS
SET name=__GAME_TEMPLATE_NAME__
SET buildDir=TEMP\
SET objectDir=%buildDir%Objects\
SET warnings=-WX -W4 -wd4100 -wd4201 -wd4324
SET includes=-Ithird_party\
SET defines=-DC_PLUS_PLUS -D_CRT_SECURE_NO_WARNINGS -DLITTLE_ENDIAN -D%platform% -DPLATFORM_ENGINE="\"%platform%\""
SET links=-link
SET linker=-subsystem:console
SET flags=-std:c++20 -Zc:preprocessor -Zc:strictStrings -GR- -EHsc

if not exist %buildDir% ( mkdir %buildDir% )
if not exist %objectDir% ( mkdir %objectDir% )

if %debugMode% == 1 (
	SET warnings=%warnings% -wd4189
	SET defines=%defines% -DDEBUG
	SET flags=%flags% -Z7 -FC -MDd
) else (
	SET flags=%flags% -MD -O2
)

cl -nologo %flags% %warnings% %defines% -Fe%buildDir%%name%.exe -Fo%objectDir% src\main.cpp %includes% %links% -INCREMENTAL:NO %linker%

:build_success
echo Build success!
goto build_end

:build_failed
echo Build failed.
goto build_end

:build_end
tools\timer.exe end