function Update-PSDashboardPanel {
    [CmdletBinding()]
    param (
        [parameter(mandatory=$true)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [parameter(mandatory=$true)]$Dashboard
    )
    $URI = Get-URI
    $Header = New-Header

    try {
        $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)
        if ($RetrievedDashboard) {
            
            try {
                if ($null -ne $RetrievedDashboard.dashboard.panels){
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