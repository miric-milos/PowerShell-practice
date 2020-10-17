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
            $sub | Format-Table -AutoSize | Out-String | Write-Host
            return # $sub
        }
    }
    # return $null
    Write-Host "No matching subs found"
}

Write-Host "Listing all subscriptions..."
Get-AllSubs | Format-Table -AutoSize | Out-String | Write-Host
$name = Read-Host "Input a name to search for"
Get-SubsByName($name)