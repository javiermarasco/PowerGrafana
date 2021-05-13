function Get-NextAvailablePanelId {
    param (
        [parameter(Mandatory = $true)]$Dashboard
    )
    if (![string]::IsNullOrEmpty($Dashboard)) {
        
        $URI = Get-GrafanaURI
        $Header = New-GrafanaHeader
        $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)

        if ($null -eq $RetrievedDashboard.dashboard.panels) {
            return 2
        }
        else {
            return $($RetrievedDashboard.dashboard.panels | Sort-Object -Property id)[$RetrievedDashboard.dashboard.panels.count - 1].id + 2
        }
    }
    else {
        Write-Output "Need to provide a Dashboard."
    }
}
