@echo off
@rem -*- coding: us-ascii-dos -*-
setlocal enabledelayedexpansion
rem
rem Released under MIT License
rem
rem Copyright (c) 2024,2026 Fumiyuki Shimizu
rem Copyright (c) 2024,2026 Abacus Technologies, Inc.
rem
rem Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
rem The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
rem THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
rem

"%SystemRoot%\System32\mode.com" con cp select=932 >nul

set "FMS_CL="
for /F "usebackq delims=" %%e in (`where.exe "%PATH%;c:\Vc7\bin:cl.exe" 2^>nul`) do (
  if "!FMS_CL!"=="" (
    set FMS_CL=%%~fe
    set FMS_CL_INCLUDE=%%~dpe..\include
    set FMS_CL_LIB=%%~dpe..\lib
  )
)
if "%FMS_CL%"=="" for %%d in ("c:\emTech" "%USERPROFILE%\Desktop") do (
  if "!FMS_CL!"=="" for /F "usebackq delims=" %%e in (`where.exe /R "%%d" cl.exe 2^>nul`) do (
    if "!FMS_CL!"=="" (
      set FMS_CL=%%~fe
      set FMS_CL_INCLUDE=%%~dpe..\include
      set FMS_CL_LIB=%%~dpe..\lib
    )
  )
)
if "%FMS_CL%"=="" (
  echo [31mCannot find cl[0m. 1>&2
  exit /b 1
)

if "%INCLUDE%"=="" (
  set "INCLUDE=%FMS_CL_INCLUDE%"
) else (
  set "INCLUDE=%FMS_CL_INCLUDE%;%INCLUDE%"
)
if "%LIB%"=="" (
  set "LIB=%FMS_CL_LIB%"
) else (
  set "LIB=%FMS_CL_LIB%;%LIB%"
)
rem source codes are expected in CP932.
rem messages are in cp932.
echo INCLUDE: %INCLUDE% 1>&2
echo LIB: %LIB% 1>&2
echo %FMS_CL% %* 1>&2
"%FMS_CL%" %*
exit /b %errorlevel%

@rem -- end of file
