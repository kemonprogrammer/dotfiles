# Get the absolute path of the Windows Startup folder
$startupFolder = [Environment]::GetFolderPath('Startup')

# $PSScriptRoot is the folder where this script lives (PROJROOT\windows\scripts)
# We navigate up one level (..) to 'windows', then into 'autohotkey'
$sourceFile = Join-Path -Path $PSScriptRoot -ChildPath "..\autohotkey\GermanKeys.ahk"

# Resolve the absolute path to ensure it's clean
$sourceFile = (Resolve-Path $sourceFile).Path

if (Test-Path $sourceFile) {
    # Define where the shortcut will live
    $shortcutLocation = Join-Path -Path $startupFolder -ChildPath "GermanKeys.lnk"
    
    # Create the COM object for Windows Script Host to make a .lnk file
    $wshShell = New-Object -ComObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut($shortcutLocation)
    
    # Set the target to your dotfiles AHK script
    $shortcut.TargetPath = $sourceFile
    $shortcut.WorkingDirectory = Split-Path $sourceFile
    $shortcut.Save()

    Write-Host "Success: Shortcut for GermanKeys.ahk created in Startup folder!" -ForegroundColor Green
} else {
    Write-Host "Error: Could not find $sourceFile" -ForegroundColor Red
}

<# 
# NOTE: If you strictly want to COPY the file instead of linking it, 
# delete the shortcut code above and uncomment the line below:

# Copy-Item -Path $sourceFile -Destination $startupFolder -Force
#>
