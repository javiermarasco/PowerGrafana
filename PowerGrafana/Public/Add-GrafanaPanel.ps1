<#

.SYNOPSIS
This cmdlet allows you to add a grafana panel to your existing dashboar.
You can provide a list of Panels as parameter to add multiple panels at once.

.DESCRIPTION
This cmdlet needs to be called in order to add the panel[s] to the grafana dashboard, this is done in this way to allow the creation of multiple panels and then add all of them in a 
single call to this cmdlet.
Note that the dashboard needs to be an PowerGrafana.Dashboard object, it can be created using the 'New-GrafanaDashboard' or in case you already have a dashboard created
a call to 'Get-GrafanaDashboard' will return the needed object.


.PARAMETER Dashboard
A grafana dashboard object provided by the output of 'New-GrafanaDashboard'
 
.PARAMETER Panel
List of panels to add to the dashboard, if nothing is provided it will create an empty panel with default values. For information on what are the default values for a penel are please use 'get-help New-GrafanaPanel'

.EXAMPLE
Add-GrafanaPanel -Dashboard (New-GrafanaDashboard -DashboardName "NewDashboard")

Add a panel with default values to a new dashboard:


.EXAMPLE
Add-GrafanaPanel -Dashboard (New-GrafanaDashboard -DashboardName "NewDashboard") -Panel $AnExistingPanel

Add an existing panel to a new dashboard:


.NOTES


.LINK
New-GrafanaDashboard
Get-GrafanaDashboard
New-GrafanaPanel

#>
function Add-GrafanaPanel{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]$Dashboard,
        [PSTypeName('PowerGrafana.Panel')][hashtable]$Panel = (New-GrafanaPanel)
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader

    try {
        $checkDashboardExist = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)
        if ($checkDashboardExist) {
            $MergedPanels = @()
            if ($null -ne $checkDashboardExist.dashboard.panels){
                $MergedPanels += $checkDashboardExist.dashboard.panels
            }
            $MergedPanels += New-Object PSObject -property $Panel
            $body = @{
                dashboard = @{
                    id            = $checkDashboardExist.meta.id
                    uid           = $checkDashboardExist.meta.uid
                    title         = $checkDashboardExist.meta.slug
                    tags          = $Tags
                    timezone      = "browser"
                    schemaVersion = 26
                    version       = $checkDashboardExist.meta.version
                    #refresh       = "25s"
                    panels        = @($MergedPanels)
                }
                folderId  = 0
                overwrite = $true
            }
            Invoke-RestMethod -Method Post -Headers $Header -Body $($body | convertto-json -Depth 10) -Uri "$URI/api/dashboards/db"
        }
    }
        catch {
        throw $_ #$("Dashboard with uid {0} does not exist." -f $Dashboard.uid)
    }
}