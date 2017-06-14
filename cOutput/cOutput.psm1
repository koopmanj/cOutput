# File: cManagementTools.psm1

Write-Verbose "Importing functions from $PSScriptRoot" -Verbose

$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

foreach($import in @($Public + $Private))
{
    try
    {
        . $import.fullname
        Write-Verbose "Function $($import.fullname) has been loaded." -Verbose
    }
    catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename