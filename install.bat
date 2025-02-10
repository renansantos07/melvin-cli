@echo off
setlocal

set SCRIPT_NAME=melvin
set INSTALL_DIR=%USERPROFILE%\melvin

echo Instalando %SCRIPT_NAME%...

:: Criar diretório de instalação, se não existir
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
)

:: Verificar se os arquivos existem antes de copiar
if exist "bin\melvin.bat" (
    copy /Y "bin\melvin.bat" "%INSTALL_DIR%\melvin.bat"
) else (
    echo ❌ Erro: Arquivo bin\melvin.bat não encontrado!
    exit /b 1
)

if exist "bin\melvin.sh" (
    copy /Y "bin\melvin.sh" "%INSTALL_DIR%\melvin.sh"
) else (
    echo ❌ Erro: Arquivo bin\melvin.sh não encontrado!
    exit /b 1
)

:: Adicionar ao PATH apenas para o usuário atual (evita necessidade de admin)
setx PATH "%INSTALL_DIR%;%PATH%"

echo ✅ Instalacao concluida! Reinicie o terminal para usar '%SCRIPT_NAME%'.
pause
exit
