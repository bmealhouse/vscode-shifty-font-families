<#
.SYNOPSIS
    Installs codeface fonts.
.DESCRIPTION
    This script was adopted from powerline/fonts.
    https://github.com/powerline/fonts/blob/master/install.sh
.EXAMPLE
    C:\PS> ./install.ps1
#>

# Clone chrissimpkins/codeface
git clone git://github.com/chrissimpkins/codeface.git

$fontFiles = New-Object 'System.Collections.Generic.List[System.IO.FileInfo]'
Get-ChildItem $PSScriptRoot/codeface/fonts -Filter "*.ttf" -Recurse | Foreach-Object {$fontFiles.Add($_)}
Get-ChildItem $PSScriptRoot/codeface/fonts -Filter "*.otf" -Recurse | Foreach-Object {$fontFiles.Add($_)}

"Copying fonts..."

$fonts = $null
foreach ($fontFile in $fontFiles) {
  if (!$fonts) {
    $shellApp = New-Object -ComObject shell.application
    $fonts = $shellApp.NameSpace(0x14)
  }
  $fonts.CopyHere($fontFile.FullName)
}

"shifty fonts installed to C:\Windows\Fonts"
