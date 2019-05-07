<# 
 .Synopsis
    Prepare to deploy Windows Virtual Desktop Environment

 .Description
    Install WVD PowerShell Modules, 
    Create WVD Resourceses:
        WVD Tenant, 
        HostPool, 
        WVD Permissions,
        First App Group,
        App Group Permissions

 .Parameter AADTenantID
    Azure Active Directory Tenant ID
        AAD Portal, Properties Copy ID

 .Parameter SubscriptionID
    Azure Subscription ID 

 .Parameter AzureADGlobalAdmin
    Azure AD Global Admin user name

 .Parameter AzureADDomainName
    Azure AD Domain Name, i.e. MSAzureAcademy.com

 .Parameter WVDTenantName
    Name of the Windows Virtual Desktop Tenant

 .Parameter WVDTenantGroup
    Tenant Group name, by default the first group is called ''

 .Parameter WVDHostPoolName
    Name of the Windows Virtual Desktop Host Pool

 .Parameter FirstAppGroupName
    Enter the name of the App Group for your Remote Applications

 .Example    
     # Create new Windows Virtual Desktop Deployment
    New-AzureWVDPrep `
        -AADTenantID xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx `
        -SubscriptionID 00000000-0000-0000-0000-000000000000 `
        -AzureADGlobalAdmin WVDAdmin `
        -AzureADDomainName MSAzureAcademy.com `
        -WVDTenantName MSAA-Tenant `
        -WVDTenantGroup 'Default Tenant Group' `
        -WVDHostPoolName MSAA-HostPool

#>

###############################
#    Create New WVD Tenant    #
###############################
New-RDSTenant `
    -Name $WVDTenantName `
    -AadTenantId $AADTenantID `
    -AzureSubscriptionId $SubscriptionID 
New-RdsHostPool `
    -TenantName $WVDTenantName `
    -Name $WVDHostPoolName `
    -FriendlyName $WVDHostPoolName
New-RdsRoleAssignment `
    -RoleDefinitionName 'RDS Owner' `
    -SignInName $FQDN `
    -TenantGroupName $WVDTenantGroup `
    -TenantName $WVDTenantName `
    -HostPoolName $WVDHostPoolName `
    -AADTenantId $AADTenantID `
    -AppGroupName 'Desktop Application Group' `
    -Verbose
