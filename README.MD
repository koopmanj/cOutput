## cOutput ##
This **cOutput** module contains 1 functions that should provide assistance for automation purposes.

### Functions ###
The functions this modules contains coexist of the following names:

New-cVerboseMessage



### Installation ###
The installation of this module can be achieved by registering a Solvinity NuGet repository:

*register-psrepository -name solget -sourcelocation "http://solget-dev.web.solvinity.com/nuget" -publishLocation "http://solget-dev.web.solvinity.com/nuget" -installationPolicy trusted*

*find-module -name cOutput*

*-or*

*find-module -name cOutput -repository solget*


### Detailed information about the functions###

NAME
    New-cVerboseMessage
    
SYNOPSIS
    Standardized verbose output.
    
    
SYNTAX
    New-cVerboseMessage [-Message] <Object> [<CommonParameters>]
    
    
DESCRIPTION
    Cause of logging variety it seemed usefull to provide a standardized way of easy reading verbose output
    

PARAMETERS
    -Message <Object>
        String containing the key of the localized message.
        
        Required?                    true
        Position?                    1
        Default value                
        Accept pipeline input?       false
        Accept wildcard characters?  false
        
    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216). 
    
INPUTS
    
OUTPUTS
    System.String
    
    
    -------------------------- EXAMPLE 1 --------------------------
    
    PS C:\>New-cVerboseMessage -message 'Something usefull' -verbose
    
    
    
    
    
    
    -------------------------- EXAMPLE 2 --------------------------
    
    PS C:\>Another example of how to use this cmdlet
    
    
    
    
    
    
    
RELATED LINKS

---



### Detailed folder structure###
+---build
+---cOutput
|   +---Private
|   \---Public
\---tests
    +---integration
    \---unit


### Contributing ###
*Solvinity Customer Engineering*

### Links ###
**[Git cOutput Repo](ssh://solvinity@solvinity.visualstudio.com:22/DefaultCollection/_git/cOutput)**
