@echo off
setlocal enabledelayedexpansion

set "REPO=renansantos07/melvin-cli"
set "INSTALL_DIR=%USERPROFILE%\melvin"
set "VERSION_FILE=%INSTALL_DIR%\VERSION"

:: Baixa a versão mais recente do GitHub e armazena em uma variável
for /f "tokens=* delims=" %%x in ('powershell -Command "(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/%REPO%/main/VERSION')"') do (
    set "VERSION=%%x"
)

:: Verifica se a versão atual já está salva
if exist "%VERSION_FILE%" (
    set /p CURRENT_VERSION=<"%VERSION_FILE%"
) else (
    set "CURRENT_VERSION=0.0.0"
)

:: Verifica se a versão baixada é diferente da versão instalada
if not "!VERSION!"=="!CURRENT_VERSION!" (
    echo 🔄 Atualizando para versão !VERSION!...
    
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/%REPO%/main/bin/melvin.sh', '%INSTALL_DIR%\melvin.sh')"
    
    echo !VERSION! > "%VERSION_FILE%"
    echo ✅ Atualização concluída!
) else (
    echo ✅ Você já está na versão mais recente (!CURRENT_VERSION!).
)

pause
