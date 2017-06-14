Set-Location $PSScriptRoot
. ..\build\cBuildManifest.ps1
git commit -am 'New version'
$remote = git remote

git push $remote master