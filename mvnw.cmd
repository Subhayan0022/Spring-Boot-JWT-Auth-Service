@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM    http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM ----------------------------------------------------------------------------
@REM Apache Maven Wrapper startup batch script, version 3.3.2
@REM
@REM Optional ENV vars
@REM   MVNW_REPOURL - repo url base for downloading maven distribution
@REM   MVNW_USERNAME/MVNW_PASSWORD - user and password for downloading maven
@REM   MVNW_VERBOSE - true: enable verbose log; debug: trace the mvnw script; others: silence the output
@REM ----------------------------------------------------------------------------

@REM Begin all REM://'m'm'm
@REM Sym links are not supported on Windows
@IF EXIST "%~dp0\.mvn\wrapper\maven-wrapper.properties" (
    @set /p __MVNW_HELPER_MAVEN_VERSION=<"%~dp0\.mvn\wrapper\maven-wrapper.properties"
)
@REM End all REM://

@echo off
@REM Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

set ERROR_CODE=0

@REM To isolate internal variables from possible post scripts, we use another setlocal
@setlocal

@REM ==== START VALIDATION ====
if NOT "%JAVA_HOME%"=="" goto OkJHome

echo.
echo Error: JAVA_HOME not found in your environment. >&2
echo Please set the JAVA_HOME variable in your environment to match the >&2
echo location of your Java installation. >&2
echo.
goto error

:OkJHome
if exist "%JAVA_HOME%\bin\java.exe" goto init

echo.
echo Error: JAVA_HOME is set to an invalid directory. >&2
echo JAVA_HOME = "%JAVA_HOME%" >&2
echo Please set the JAVA_HOME variable in your environment to match the >&2
echo location of your Java installation. >&2
echo.
goto error

@REM ==== END VALIDATION ====

:init

@REM Find the project base dir, i.e. the directory that contains the folder ".mvn".
@REM Fallback to current working directory if not found.

set MAVEN_PROJECTBASEDIR=%MAVEN_BASEDIR%
IF NOT "%MAVEN_PROJECTBASEDIR%"=="" goto endDetectBaseDir

set EXEC_DIR=%CD%
set WDIR=%EXEC_DIR%
:findBaseDir
IF EXIST "%WDIR%"\.mvn goto baseDirFound
cd ..
IF "%WDIR%"=="%CD%" goto baseDirNotFound
set WDIR=%CD%
goto findBaseDir

:baseDirFound
set MAVEN_PROJECTBASEDIR=%WDIR%
cd "%EXEC_DIR%"
goto endDetectBaseDir

:baseDirNotFound
set MAVEN_PROJECTBASEDIR=%EXEC_DIR%
cd "%EXEC_DIR%"

:endDetectBaseDir

IF NOT EXIST "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties" goto endReadAdditionalProperties

@setlocal EnableExtensions EnableDelayedExpansion
for /F "usebackq delims=" %%a in ("%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties") do (
    set "line=%%a"
    for /F "tokens=1,2 delims==" %%b in ("!line!") do (
        if "%%b"=="distributionUrl" set "MVNW_REPOURL_PROP=%%c"
    )
)
@endlocal & set MVNW_REPOURL=%MVNW_REPOURL_PROP%

:endReadAdditionalProperties

SET "distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.9/apache-maven-3.9.9-bin.zip"
SET "MAVEN_HOME=%USERPROFILE%\.m2\wrapper\dists\apache-maven-3.9.9"

IF EXIST "%MAVEN_HOME%" goto mavenHomeExists
echo Downloading from: %distributionUrl%

powershell -Command ^
    $ProgressPreference = 'SilentlyContinue'; ^
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; ^
    Invoke-WebRequest -Uri '%distributionUrl%' -OutFile '%TEMP%\apache-maven-3.9.9-bin.zip'

powershell -Command ^
    $ProgressPreference = 'SilentlyContinue'; ^
    Expand-Archive -Path '%TEMP%\apache-maven-3.9.9-bin.zip' -DestinationPath '%USERPROFILE%\.m2\wrapper\dists' -Force

del "%TEMP%\apache-maven-3.9.9-bin.zip"

:mavenHomeExists

set MAVEN_CMD="%MAVEN_HOME%\bin\mvn"

%MAVEN_CMD% %*
if ERRORLEVEL 1 goto error
goto end

:error
set ERROR_CODE=1

:end
@endlocal & set ERROR_CODE=%ERROR_CODE%

if not "%MAVEN_TERMINALOUTPUT%"=="" call "%MAVEN_TERMINALOUTPUT%" %ERROR_CODE%

cmd /C exit /B %ERROR_CODE%
