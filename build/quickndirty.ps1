Set-Location $PSScriptRoot
. cBuildManifest.ps1
git commit -am 'New version'
$remote = git remote

git push $remote master