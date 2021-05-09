<#

.SYNOPSIS
Retrieve a Grafana dashboard from a dashboard id

.DESCRIPTION
This cmdlet will retrieve a Grafana dashboard represented as a PowerGrafana.Dashboard object that can be later be used to add panels to it.

.PARAMETER DashboardId
This is a number representing the Grafana dashboard id, this is also called "uid".

.EXAMPLE
Get-GrafanaDashboard -DashboardId usi13s

.NOTES

.LINK

#>
function Get-GrafanaDashboard {
    param (
        [Parameter(Mandatory=$false)]$DashboardId
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader
    $RetrievedDashboard = $(Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $DashboardId)).dashboard
    $RetrievedDashboard.PSObject.TypeNames.Insert(0, 'PowerGrafana.Dashboard')
    return $RetrievedDashboard
}