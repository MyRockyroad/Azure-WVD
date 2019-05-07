###########################################
#    Install PowerShell Module for WVD    #
###########################################
$Module = 'Microsoft.RDInfra.RDPowerShell'
if((Test-Path -Path "C:\Program Files\WindowsPowerShell\Modules\$Module" -ErrorAction SilentlyContinue)-eq $true) {
        if((Get-Module -Name $Module -ErrorAction SilentlyContinue) -eq $false) {
            Write-Host `
                -ForegroundColor Cyan `
                -BackgroundColor Black `
                "Importing Module"        
            Import-Module -Name $Module -Verbose -ErrorAction SilentlyContinue

        }
        Else {
            Write-Host `
                -ForegroundColor Yellow `
                -BackgroundColor Black `
                "Module already imported"        
        }
    }
else {
        Install-Module -Name $Module -Force -Verbose -ErrorAction Stop    
    }

