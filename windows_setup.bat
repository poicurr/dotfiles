@echo off
setlocal enabledelayedexpansion

REM Resolve repo root from this script
set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%\..") do set "DOTFILES_DIR=%%~fI"
set "VIMRC_SRC=%DOTFILES_DIR%\.vimrc"

echo [1/5] Install Vim, Git, LLVM (Clang toolchain), NodeJS (winget)
where winget >nul 2>nul || (echo ERROR: winget not found.& goto :AFTER_PKGS)

winget install --id Vim.Vim
winget install --id Git.Git
winget install --id LLVM.LLVM
winget install --id OpenJS.NodeJS

:AFTER_PKGS
echo [2/5] Place .vimrc
if exist "%VIMRC_SRC%" (
  copy /Y "%VIMRC_SRC%" "%USERPROFILE%\.vimrc" >nul
) else (
  echo WARN: %VIMRC_SRC% not found.
)

echo [3/5] Ensure Prettier
where prettier >nul 2>nul || call npm i -g prettier

echo [4/5] Install Powerline Fonts
set "TMPF=%TEMP%\plfonts_%RANDOM%"
git clone --depth=1 https://github.com/powerline/fonts.git "%TMPF%" >nul 2>nul
if exist "%TMPF%\install.ps1" (
  powershell -ExecutionPolicy Bypass -File "%TMPF%\install.ps1"
) else if exist "%TMPF%\fonts\install.ps1" (
  powershell -ExecutionPolicy Bypass -File "%TMPF%\fonts\install.ps1"
)
rmdir /S /Q "%TMPF%" >nul 2>nul

echo [5/5] Done. Start Vim and run :call dein#install()
endlocal
