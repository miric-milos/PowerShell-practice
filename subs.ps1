. .\global_func.ps1

# 1) Connect-AzAccount

# 2)
function Get-AllSubs {
    $subs = Get-AzSubscription
    return $subs
}

# 3)
function Get-SubsByName($name) {
    $subs = Get-AllSubs

    foreach ($sub in $subs) {
        if($sub.Name -eq $name) {
            Out-AsTable($sub)
            return # $sub
        }
    }
    # return $null
    Write-Host "No matching subs found"
}

Write-Host "Listing all subscriptions..."
Out-AsTable(Get-AllSubs)

$name = Read-Host "Input a name to search for"
Get-SubsByName($name)