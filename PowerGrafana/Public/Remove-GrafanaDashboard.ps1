function Remove-GrafanaDashboard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]$Dashboard
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader
    Return $(Invoke-RestMethod -Method Delete -Headers $Header  -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)).message
}