Set-Location $PSScriptRoot -Verbose

Write-Verbose -Message "$env:COMPUTERNAME : dotsourcing the cBuildManifest" -Verbose
. .\cBuildManifest.ps1

Write-Verbose -Message "$env:COMPUTERNAME : git commit -am 'New Version'" -Verbose
git commit -am 'New version'

$remote = git remote
Write-Verbose -Message "$env:COMPUTERNAME : git remote : $remote" -Verbose

Write-Verbose -Message "$env:COMPUTERNAME : git push $remote master" -Verbose
git push $remote master