function Add-PSPanel{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]$Dashboard,
        [PSTypeName('PowerGrafana.Panel')][hashtable]$Panel = (New-Panel)
    )
    $URI = Get-URI
    $Header = New-Header

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