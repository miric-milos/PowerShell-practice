function Out-AsTable ($list) {
    if($null -eq $list) {
        return
    }
    $list | Format-Table -AutoSize | Out-String | Write-Host
}