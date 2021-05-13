<#

.SYNOPSIS
Removes a Grafana dashboard.

.DESCRIPTION
This cmdlet can be used to delete a complete dashboard, it will delete all the other resources defined inside the dashboard such as panels, targets, alerts, etc.

.PARAMETER Dashboard
A PowerGrafana.Dashboard object that can be retrieved by "Get-GrafanaDashboard"

.EXAMPLE
Remove-GrafanaDashboard -Dashboard $MyGrafanaDashboard

.NOTES

.LINK
Get-GrafanaDashboard

#>
function Remove-GrafanaDashboard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]$Dashboard
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader
    Return $(Invoke-RestMethod -Method Delete -Headers $Header  -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)).message
}