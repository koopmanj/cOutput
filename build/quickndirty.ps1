Set-Location $PSScriptRoot
. ..\build\cBuildManifest.ps1
git commit -am 'New version'
git push vso master