function Get-GrafanaPanel {

    param (
        [Parameter(Mandatory=$true)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [Parameter(Mandatory=$true)] $Dashboard
    )

    if (![string]::IsNullOrEmpty($Panel.id) -and ![string]::IsNullOrEmpty($Dashboard)  ) {
        $URI = Get-GrafanaURI
        $Header = New-GrafanaHeader
        $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)
        if ( $($RetrievedDashboard.dashboard.panels | where-object -property id -eq $Panel.id).count -gt 0) {
            $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $Panel.id
        }
        else {
            $PanelFound = $null
        }
        $PanelFound.PSObject.TypeNames.Insert(0, 'PowerGrafana.Panel')
        return $PanelFound
    }

}
        