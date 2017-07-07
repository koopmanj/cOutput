#Set verbose logging
$VerbosePreference = 'Continue'

#Set error handling
$ErrorActionPreference = 'Continue'

#Set script location
Set-Location $PSScriptRoot

Write-Information -MessageData "$env:COMPUTERNAME : Build of manifest started" -InformationAction Continue

#Query the name of the folder one level up
[string]$ModuleName = (Get-ChildItem ..\ ).psparentpath[-1].split('\')[-1]

#Summarize all functions found within the ModuleFile
function Get-ModuleFunctions {
    param(
        [parameter(Mandatory = $true)]
        $ModuleName
    )
        
    $PublicFunctions = Get-ChildItem -Path ..\$ModuleName\Public
    $Functions = $PublicFunctions.ForEach( {
            Get-Content -Path $_.fullname | Select-String -Pattern 'Function '
        })

    #Trim the output, so strip the function word,curly braces, and whitespaces
    $TrimmedFunctionNames = $Functions -ireplace '(function)|\s|{', ''

    return $TrimmedFunctionNames
}

$ModuleFunctions = Get-ModuleFunctions -ModuleName $ModuleName

#Query all files within the source path of the folder
[array]$ModuleFile = (Get-ChildItem -Filter *.psm1 -Path ..\$ModuleName)

if ($null -eq $ModuleFile) {
    Write-Warning -Message "$env:COMPUTERNAME : No files found to include for Manifest (psd1)"
    exit 1
}
else {
    Write-Verbose -Message "$env:COMPUTERNAME : File to include for Manifest (psd1) : $($ModuleFile.name|Out-String) "
}

if ($null -eq $ModuleFunctions) {
    Write-Warning -Message "$env:COMPUTERNAME : No functions found to include for Manifest (psd1)"
    exit 1
}
else {
    Write-Verbose -Message "$env:COMPUTERNAME : Functions to include for Manifest (psd1) : $($ModuleFunctions|Out-String) "
}
        
#Get all content, filter on ModuleVersion, replace non-relevant characters
if (Test-Path ..\$ModuleName\$ModuleName.psd1) {
    Write-Verbose -Message "$env:COMPUTERNAME : Manifest found, rendering a new manifest(psd1) build number"
    $ManifestContent = Get-Content ..\$ModuleName\$ModuleName.psd1
    $ModuleManifestVersion = $ManifestContent | Select-String -Pattern 'ModuleVersion'
    [version]$ModuleManifestVersionNumber = $ModuleManifestVersion -ireplace "[A-Za-z =']", ''
    [version]$ModuleManifestVersionNumber = "$($ModuleManifestVersionNumber.Major).$($ModuleManifestVersionNumber.Minor).$($ModuleManifestVersionNumber.Build).$($ModuleManifestVersionNumber.Revision+1)"
    Write-Verbose -Message "$env:COMPUTERNAME : Build number  : $ModuleManifestVersionNumber"
    

}
else {
    Write-Verbose -Message "$env:COMPUTERNAME : No valid manifest found, rendering a new manifest with version 1.0.0.0 (psd1) : `n$($TrimmedFunctionNames|Out-String) "
    [version]$ModuleManifestVersionNumber = '1.0.0.0'
}
#Render the manifest
try {
    New-ModuleManifest  -Path ..\$ModuleName\$ModuleName.psd1 -NestedModules $ModuleFile.name -Author (whoami) -RootModule "$ModuleName.psm1" `
        -CompanyName Solvinity -Copyright © -ModuleVersion $ModuleManifestVersionNumber -Description 'Help module for daily maintenance' `
        -FunctionsToExport $TrimmedFunctionNames -CmdletsToExport @() -AliasesToExport '' -Verbose
}
catch {
    Write-Error -Message "$env:COMPUTERNAME : Failed to render a manifest"
    exit 1
}

if ($LASTEXITCODE -eq 0) {
    Write-Information -MessageData "$env:COMPUTERNAME : Build of manifest was fulfilled with success" -InformationAction Continue
}

#Render the manifest
try {
    .\cBuildMarkdown.ps1
}
catch {
    Write-Error -Message "$env:COMPUTERNAME : Failed to render a markdown"
    exit 1
}

if ($LASTEXITCODE -eq 0) {
    Write-Information -MessageData "$env:COMPUTERNAME : Build of markdown was fulfilled with success" -InformationAction Continue
}