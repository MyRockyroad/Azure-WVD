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
