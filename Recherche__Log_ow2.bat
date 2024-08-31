@echo off
setlocal enabledelayedexpansion

:: Chemin Overwatch (modifier si nécessaire)
set "overwatchPath=%ProgramFiles(x86)%\Overwatch"

:: Vérifier si le dossier Overwatch existe
if not exist "%overwatchPath%" (
    echo Le dossier Overwatch n'existe pas.
    pause
    exit /b 1
)

:: Attendre un peu pour s'assurer que le jeu est fermé (ajuster le délai si nécessaire)
echo Attente de la fermeture du jeu...
timeout /t 5 /nobreak

:: Déterminez la langue du système
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage ^| findstr /i "InstallLanguage"') do (
    set "systemLanguage=%%a"
)

:: Définir le dossier de log en fonction de la langue
if "%systemLanguage%"=="040C" (
    set "logFolder=%USERPROFILE%\Documents\Overwatch\Logs"  :: Français
) else if "%systemLanguage%"=="0409" (
    set "logFolder=%USERPROFILE%\Documents\Overwatch\Logs"  :: Anglais
) else (
    echo Langue non prise en charge. No supported language.
    pause
    exit /b 1
)

:: Rechercher le dernier fichier Overwatch.log
set "latestLog="
for /f "delims=" %%f in ('dir /b /od "%logFolder%\Overwatch*.log" 2^>nul') do (
    set "latestLog=%%f"
)

:: Ouvrir le dernier fichier Overwatch.log avec Notepad si trouvé
if defined latestLog (
    start notepad.exe "%logFolder%\!latestLog!"
    echo Le dernier fichier de journal Overwatch a été trouvé : !latestLog!
) else (
    echo Aucun fichier de journal Overwatch n'a été trouvé.
)

endlocal
pause
