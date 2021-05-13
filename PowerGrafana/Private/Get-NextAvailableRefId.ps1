function Get-NextAvailableRefId {
    param (
        [PSTypeName('PowerGrafana.Panel')] $Panel,
        $Dashboard
    )

    $AZ = 'A'..'Z' 

    if (![string]::IsNullOrEmpty($Panel)) {
        $InternalPanel = Get-GrafanaPanel -Panel $Panel -Dashboard $Dashboard
        $PanelsRefIds = $($InternalPanel.targets.RefId | Sort-Object)
        if ($PanelsRefIds.count -gt 25) {
            return -1
        }
        else {
            return $AZ[$AZ.indexof([char]$PanelsRefIds) + 1]
        }
    }
    else {
        Write-Output "Need to provide a Panel."
    }
}
