#######################
#    Setup WVD Apps   #
#######################   
$RemoteApps = @(
    @{AppGroupName = 'MSAA-WVD'; FilePath = '7zFM.exe'}    
    @{AppGroupName = 'MSAA-WVD'; FilePath = 'Calc.exe'}    
    @{AppGroupName = 'MSAA-WVD'; FilePath = 'Code.exe'}
    @{AppGroupName = 'MSAA-WVD'; FilePath = 'FoxITReader.exe'}
    @{AppGroupName = 'MSAA-WVD'; FilePath = 'HandBrake.exe'}
    @{AppGroupName = 'MSAA-WVD'; FilePath = 'Paint.net'}
    @{AppGroupName = 'MSAA-WVD'; FilePath = 'Putty.exe'}       
    @{AppGroupName = 'MSAA-WVD'; FilePath = 'WinRar'}
)        
foreach ($App in $RemoteApps) {
    Get-RdsStartMenuApp `
        -TenantName $WVDTenantName `
        -HostPoolName $WVDHostPoolName `
        -AppGroupName $App.AppGroupName `
            | ? FilePath -Match $App.FilePath `
            -OutVariable NewApp
           
    New-RdsRemoteApp `
        -TenantName $WVDTenantName `
        -HostPoolName $WVDHostPoolName `
        -AppGroupName $App.AppGroupName `
        -Name $NewApp.FriendlyName `
        -Filepath $NewApp.filepath  `
        -IconPath $NewApp.iconpath `
        -IconIndex $NewApp.iconindex
}