@echo off
REM build.bat

REM Defina caminhos
set RGBASM=rgbasm.exe
set RGBLINK=rgblink.exe
set RGBFIX=rgbfix.exe

REM Cria diretório de saída se não existir
if not exist build mkdir build

REM Montagem
%RGBASM% -o build\code.o -i include -i assets src\code.asm
if errorlevel 1 goto :error

REM Linkagem
%RGBLINK% -o build\first_jogo.gb build\code.o
if errorlevel 1 goto :error

REM Corrige cabeçalho
%RGBFIX% -v -p 0 build\first_jogo.gb

echo.
echo Build concluído com sucesso!
goto :eof

:error
echo.
echo Erro durante o processo de build.
exit /b 1
