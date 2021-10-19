<#
a stupid script for pulling dependencies for AHK from git. 

I tried to think of Better ways for doing this, but the Lib folder
is stupid so I couldn't.
#>
$dumbFile = ".\dumb.txt"
if (-Not(Test-Path -Path $dumbFile -PathType Leaf)) {
    Write-Host "You don't have it. Here you go ~~~~~"
    Out-File -FilePath $dumbFile
    exit
}
$libFolder = ".\.tmp-lib"
Remove-Item -Recurse -Force $libFolder -ErrorAction:Ignore
Write-Host hi
New-Item -ItemType Directory -Path $libFolder
Set-Location $libFolder
Write-Host hi

foreach($line in Get-Content "..\$dumbFile") {
    Write-Host $line
    git clone $line last
    Remove-Item .\last\.git -Recurse -Force
    Copy-Item -Path .\last\* -Recurse -Force -Destination .\
    Remove-Item .\last -Recurse -Force
}
Set-Location ..
Write-Host "Goodbye old lib folder"
Remove-Item -Force -Recurse -Path .\Lib -ErrorAction:Ignore
Move-Item $libFolder .\Lib

