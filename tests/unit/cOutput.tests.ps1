#Set verbose logging
$VerbosePreference = 'SilentlyContinue'

#Set warning logging
$WarningPreference = 'SilentlyContinue'

#Set error handling
$ErrorActionPreference = 'Continue'

#Set script location
Set-Location $PSScriptRoot
Write-Verbose -Message "Set scriptlocation : $PSScriptRoot"

#Query the name of the folder one level up
$ModuleName = [string]$ModuleName = (Get-ChildItem ..\..\).psparentpath[-1].split('\')[-1]
Write-Verbose -Message "ModuleName : $ModuleName"

#Query the name of the manifest
[string]$ModuleManifest = (Get-ChildItem -Filter *.psd1 -Path ..\..\$ModuleName)
Write-Verbose -Message "$env:COMPUTERNAME : The location of the module is : $ModuleManifest"

#Remove the module
Remove-Module -Name $ModuleName -Force -ErrorAction SilentlyContinue

#Import the module
Import-Module -Name ..\..\$ModuleName\$ModuleManifest -Force -ErrorAction Stop

Describe $ModuleName {
    Context New-cVerboseMessage {
        $VerbOutput = New-cVerboseMessage -message "Team Avengers Member" -Verbose 4>&1
        $ComputerName = $env:COMPUTERNAME
        
        It 'New-cVerboseMessage -message "Team Avengers Member" should return a computername' {
            {
                $VerbOutput | Should contains $ComputerName
            } 
        }
        It 'New-cVerboseMessage -message "Team Avengers Member" should return a datetime' {
            {
                $VerbOutput | Should contains get-date
            } 
        }
        It 'New-cVerboseMessage -message "Team Avengers Member" should return a type of System.Management.Automation.VerboseRecord
    '   {
            {
                (($VerbOutput.GetType()).Fullname) | Should be 'System.Management.Automation.VerboseRecord'
            } 
        }
    }
}