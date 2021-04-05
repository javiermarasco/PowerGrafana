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