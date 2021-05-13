<#

.SYNOPSIS
Replaces a Panel in a Dashboard.

.DESCRIPTION
This cmdlet can be used to replace an existing Panel in a Dashboard with a new provided Panel.

.PARAMETER Panel
A PowerGrafana.Panel that is the Panel we want to update, this can be retrieved with "Get-GrafanaPanel", then updated and then provided to this cmdlet to be reflected in Grafana.

.PARAMETER Dashboard
A PowerGrafana.Dashboard object where we will be replacing the panel.

.EXAMPLE

.NOTES

.LINK
Get-GrafanaPanel

#>
function Update-GrafanaDashboardPanel {
    [CmdletBinding()]
    param (
        [parameter(mandatory = $true)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [parameter(mandatory = $true)]$Dashboard
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader

    try {
        $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)
        if ($RetrievedDashboard) {
            
            try {
                if ($null -ne $RetrievedDashboard.dashboard.panels) {
                    $LookupPanel = $RetrievedDashboard.dashboard.panels | Where-Object -Property id -eq $Panel.id
                    $UpdatedPanelList = @()
                    $UpdatedPanelList = $RetrievedDashboard.dashboard.panels
                    $UpdatedPanelList[$RetrievedDashboard.dashboard.panels.indexof($LookupPanel)] = $Panel
                    
                    $body = @{
                        dashboard = @{
                            id            = $RetrievedDashboard.meta.id
                            uid           = $RetrievedDashboard.meta.uid
                            title         = $RetrievedDashboard.meta.slug
                            tags          = $Tags
                            timezone      = "browser"
                            schemaVersion = 26
                            version       = $RetrievedDashboard.meta.version
                            refresh       = "25s"
                            panels        = @($UpdatedPanelList)
                        }
                        folderId  = 0
                        overwrite = $true
                    }
                    Invoke-RestMethod -Method Post -Headers $Header -Body $($body | convertto-json -Depth 10) -Uri "$URI/api/dashboards/db"
                }
            }
            catch {
                throw $_ #$("Panel not found in dashboard with uid {0}." -f $Dashboard.uid)
            }
        }
    }
    catch {
        throw $_ #$("Dashboard with uid {0} does not exist." -f $Dashboard.uid)
  
    }
}