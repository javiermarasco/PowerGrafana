<#

.SYNOPSIS
Creates a dashboard in Grafana

.DESCRIPTION
This cmdlet will create an empty dashboard in Grafana that can be used as starting point to create your grafana monitoring.

.PARAMETER DashboardName
The name of the dasboard in Grafana.

.PARAMETER Tags
An array of strings that will be used to set tags in the dashboard.

.EXAMPLE
New-GrafanaDashboard -DashboardName "My new dashboard" -Tags @('Web','Azure','Production')

.NOTES

.LINK

#>
function New-GrafanaDashboard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]$DashboardName,
        [Parameter(Mandatory=$false)][string[]]$Tags
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader
    $body = @{
        dashboard = @{
            id            = $null
            uid           = $null
            title         = $dashboardName
            tags          = $Tags
            timezone      = "browser"
            schemaVersion = 26
            version       = 0
            #refresh       = "25s"
        }
        folderId  = 0
        overwrite = $false
    }
    Invoke-RestMethod -Method Post -Headers $Header -Body $($body | convertto-json -Depth 2) -Uri "$URI/api/dashboards/db"
}