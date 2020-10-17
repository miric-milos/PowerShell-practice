
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

function Get-SortedVMs {
    $sorted = Get-RunningVms | Sort-Object -Property Name
    return $sorted
}

function Get-TemplateFromVM($vm) {
    
    $resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
    
# I have tried exporting templates directly from the VM in portal, always throws an error that parameteres aint valid

    New-AzResourceGroupDeployment `
        -ResourceGroupName "myResourceGroup" `
        -TemplateFile "C:\Users\Milos\Desktop\GitHub interview prep\template.json" `
        -TemplateParameterFile "C:\Users\Milos\Desktop\GitHub interview prep\parameters.json"
        
    (Get-AzVm -ResourceGroupName "myResourceGroup").name
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
Write-Host "Listing vCPU usages for" $location"..."
Out-AsTable(Get-CPUUsage($location))

# 6)
Write-Host "Listing running Linux VMs..."
Get-LinuxVMs

$vms = Get-RunningVms
Get-TemplateFromVM($vms[0])