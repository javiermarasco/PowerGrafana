<#

.SYNOPSIS
Returns a Grafana Panel that can be used later to add targets and alerts to it.

.DESCRIPTION
This cmdlet will return a Grafana Panel that can be used to add targets and alerts to it, You must provide either Dashboard (a PowerGrafana.Dashboard object) or a DashboardId (A uid for an existing dashboard).

.PARAMETER Panel
A PowerGrafana.Panel that represents a panel, this is added to support other cmdlets that depend on this one, this is an optional parameter and can be ignored if PanelId is provided.

.PARAMETER PanelId
A number representing a panel in Grafana.

.PARAMETER Dashboard
[Optional] a PowerGrafana.Dashboard object, this will be used to obtain the uid of the dashboard.

.PARAMETER DashboardId
[Optional] the uid of an existing dashboard

.EXAMPLE
Get-GrafanaPanel -PanelId 2 -Dashboard $GrafanaDashboard

.EXAMPLE
Get-GrafanaPanel -PanelId 2 -DashboardId "u2isj3"


.NOTES

.LINK

#>
function Get-GrafanaPanel {

    param (
        [Parameter(Mandatory=$false)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [Parameter(Mandatory=$false)] $PanelId,
        [Parameter(Mandatory=$false)] $Dashboard,
        [Parameter(Mandatory=$false)] $DashboardId
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader

    if ([string]::IsNullOrEmpty($Dashboard)){
        $QueryUri = $("$URI/api/dashboards/uid/" + $DashboardId)
    }else{
        $QueryUri =$("$URI/api/dashboards/uid/" + $Dashboard.uid)
    }

    if ([string]::IsNullOrEmpty($Panel)){
        $QueryPanelId = $PanelId
    }else{
        $QueryPanelId = $Panel.id
    }
    $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $QueryUri
    
    $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $QueryPanelId
    $OutputPanel = @{}
    $OutputPanel = $PanelFound | ConvertTo-Json -Depth 8 | ConvertFrom-Json -Depth 8 -AsHashtable
    $OutputPanel.PSObject.TypeNames.Insert(0, 'PowerGrafana.Panel')
    return $OutputPanel
}
        