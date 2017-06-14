<#
.Synopsis
   Standardized verbose output.
.DESCRIPTION
   Cause of logging variety it seemed usefull to provide a standardized way of easy reading verbose output
.PARAMETER Message
    String containing the key of the localized message.
.EXAMPLE
   New-cVerboseMessage -message 'Something usefull' -verbose
.EXAMPLE
   Another example of how to use this cmdlet
#>
function New-cVerboseMessage {
    [CmdletBinding(
        ConfirmImpact = "High"
    )]
    [OutputType([String])]
    
    Param
    (
        [Parameter(Mandatory = $true)]
        $Message
    )
    Write-Verbose -Message "$env:COMPUTERNAME : $(Get-Date -format yyyy-MM-dd.HH:mm:ss) : $Message" -Verbose
}