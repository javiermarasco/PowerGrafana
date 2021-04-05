function Get-GrafanaPanel {

    param (
        [Parameter(Mandatory=$false)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [Parameter(Mandatory=$false)] $PanelId,
        [Parameter(Mandatory=$false)] $Dashboard,
        [Parameter(Mandatory=$false)] $DashboardId
    )

    if (![string]::IsNullOrEmpty($Panel.id) -and ![string]::IsNullOrEmpty($Dashboard)  ) {
        $URI = Get-GrafanaURI
        $Header = New-GrafanaHeader
        if (![string]::IsNullOrEmpty($Dashboard) ){
            $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)
            if ( $($RetrievedDashboard.dashboard.panels | where-object -property id -eq $Panel.id).count -gt 0) {
                $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $Panel.id
            }
            else {
                $PanelFound = $null
            }
        }else{
            $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $DashboardId)
            if ( $($RetrievedDashboard.dashboard.panels | where-object -property id -eq $PanelId).count -gt 0) {
                $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $PanelId
            }
            else {
                $PanelFound = $null
            }
        }
        
        
        $PanelFound.PSObject.TypeNames.Insert(0, 'PowerGrafana.Panel')
        return $PanelFound
    }

}
        