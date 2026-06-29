@echo off
echo =======================================
echo         Git Auto Update Script
echo =======================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Git is not installed or not in PATH.
    pause
    exit /b
)

:: Get current branch
for /f "tokens=*" %%i in ('git branch --show-current') do set BRANCH=%%i
if "%BRANCH%"=="" (
    echo Error: Not a git repository or no branch found.
    pause
    exit /b
)

echo Current branch is: %BRANCH%
echo.

:: Stage all changes
echo Staging all changes...
git add .
if %errorlevel% neq 0 (
    echo Error: Failed to stage changes.
    pause
    exit /b
)

:: Prompt user for commit message
set /p commit_msg="Enter commit message (press Enter for 'Auto update'): "
if "%commit_msg%"=="" set commit_msg=Auto update

:: Commit changes
echo.
echo Committing changes...
git commit -m "%commit_msg%"
if %errorlevel% neq 0 (
    echo Info: No changes to commit or commit failed.
)

:: Push to remote
echo.
echo Pushing changes to remote repository on branch %BRANCH%...
git push origin %BRANCH%
if %errorlevel% neq 0 (
    echo Error: Push failed. Please check your internet connection or git credentials.
    pause
    exit /b
)

echo.
echo =======================================
echo   Git update completed successfully!
echo =======================================
pause
