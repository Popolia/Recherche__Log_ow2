@echo off

:: Chemin Overwatch
cd /d "%ProgramFiles(x86)%\Overwatch"

:: Attendez que le jeu se ferme (peut-être ajoutez un délai plus long si nécessaire)
echo Recherche de log
timeout /t 1 /nobreak

:: Vérifiez si Visual Studio Code est installé
set "codeInstalled=false"
where code >nul 2>nul
if %errorlevel%==0 (
    set "codeInstalled=true"
)

:: Déterminez la langue du système
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage ^| findstr /i "InstallLanguage"') do (
    set "systemLanguage=%%a"
)

:: Définissez le dossier de log en fonction de la langue
if "%systemLanguage%"=="040C" (
    set "logFolder=C:\Users\Admin\Documents\Overwatch\Logs"  :: Français
) else if "%systemLanguage%"=="0409" (
    set "logFolder=C:\Users\Admin\Documents\Overwatch\Logs"  :: Anglais
) else (
    echo Langue non prise en charge. No supported language.
    pause
    exit /b 1
)

:: Ouvrez le dernier fichier Overwatch.log avec Notepad
setlocal enabledelayedexpansion

set "latestLog="
for /f "delims=" %%f in ('dir /b /od "%logFolder%\Overwatch*.log"') do (
    set "latestLog=%%f"
)

if defined latestLog (
    start notepad.exe "%logFolder%\!latestLog!"
    echo Le Dernier fichier de journal Overwatch a été trouvé.
    echo The latest Overwatch log file has been found.
) else (
    echo Aucun fichier de journal Overwatch n'a été trouvé. No Overwatch log files were found.
         No Overwatch log files were found. No Overwatch log files were found.
)

endlocal