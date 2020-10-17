
. .\global_func.ps1

function Get-RunningVms {
    $vms = Get-AzVM
    return $vms
}

function Get-LinuxVMs {
    $vms = Get-RunningVms

    # Using arrayList to store Linux VMs
    $list = New-Object -TypeName "System.Collections.ArrayList"
    foreach ($vm in $vms) {
        if ($vm.StorageProfile.OsDisk.OsType -eq "Linux") {
            $list += $vm
        }
    }

    Out-AsTable($list)
}

function Get-CPUUsage($location) {
    if ($null -eq $location -or $location -eq "") {
        Write-Host "No location provided"
        return
    }
      
    $usage = Get-AzVMUsage -Location $location
    return $usage
}

# 4) 
Write-Host "Listing all running VMs..."
# Outputing Vms to write-host stream instead of standard stream
# in order to avoid desynchronization
Out-AsTable(Get-RunningVms)

# 5)
$location = Read-Host "Type in a location to search for"
Out-AsTable(Get-CPUUsage($location))

# 6)
Get-LinuxVMs