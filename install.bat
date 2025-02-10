@echo off
setlocal

set SCRIPT_NAME=melvin
set INSTALL_DIR=%USERPROFILE%\melvin
set BIN_DIR=%INSTALL_DIR%\bin
set REPO=renansantos07/melvin-cli

echo Instalando %SCRIPT_NAME%...

:: Criar diretório de instalação, se não existir
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)
if not exist "%BIN_DIR%" (
    mkdir "%BIN_DIR%"
)

:: Baixar os arquivos necessários diretamente do GitHub, se não existirem
if not exist "%BIN_DIR%\melvin.bat" (
    echo Baixando melvin.bat do GitHub...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/%REPO%/main/bin/melvin.bat', '%BIN_DIR%\melvin.bat')"
)

if not exist "%BIN_DIR%\melvin.sh" (
    echo Baixando melvin.sh do GitHub...
    powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/%REPO%/main/bin/melvin.sh', '%BIN_DIR%\melvin.sh')"
)

:: Verificar se os arquivos foram baixados corretamente
if not exist "%BIN_DIR%\melvin.bat" (
    echo ❌ Erro: Arquivo melvin.bat não foi encontrado ou baixado corretamente!
    exit /b 1
)

if not exist "%BIN_DIR%\melvin.sh" (
    echo ❌ Erro: Arquivo melvin.sh não foi encontrado ou baixado corretamente!
    exit /b 1
)

:: Copiar os arquivos para o diretório de instalação
copy /Y "%BIN_DIR%\melvin.bat" "%INSTALL_DIR%\melvin.bat"
copy /Y "%BIN_DIR%\melvin.sh" "%INSTALL_DIR%\melvin.sh"

:: Adicionar ao PATH apenas para o usuário atual (evita necessidade de admin)
setx PATH "%INSTALL_DIR%;%PATH%"

echo ✅ Instalação concluída! Reinicie o terminal para usar '%SCRIPT_NAME%'.
pause
exit
