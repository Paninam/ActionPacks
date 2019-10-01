﻿#Requires -Version 5.0
#Requires -Modules Microsoft.Online.SharePoint.PowerShell

<#
    .SYNOPSIS
        Returns SharePoint Online organization properties
    
    .DESCRIPTION  

    .NOTES
        This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
        The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
        The terms of use for ScriptRunner do not apply to this script. In particular, ScriptRunner Software GmbH assumes no liability for the function, 
        the use and the consequences of the use of this freely available script.
        PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of ScriptRunner Software GmbH.
        © ScriptRunner Software GmbH

    .COMPONENT
        Requires Module Microsoft.Online.SharePoint.PowerShell
        ScriptRunner Version 4.2.x or higher

    .LINK
        https://github.com/scriptrunner/ActionPacks/tree/master/O365/SharePointOnline/Tenant

    .Parameter Properties
        List of comma separated properties to expand. Use * for all properties
#>

param(            
    [string]$Properties = 'AllowEditing,PublicCdnAllowedFileTypes,ExternalServicesEnabled,StorageQuotaAllocated,ResourceQuotaAllocated,OneDriveStorageQuota'
)

Import-Module Microsoft.Online.SharePoint.PowerShell

try{
    if([System.String]::IsNullOrWhiteSpace($Properties)){
        $Properties = '*'
    }
    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'}      
    
    $result = Get-SPOTenant @cmdArgs | Select-Object $Properties.Split(',')
      
    if($SRXEnv) {
        $SRXEnv.ResultMessage = $result
    }
    else {
        Write-Output $result 
    }    
}
catch{
    throw
}
finally{
}