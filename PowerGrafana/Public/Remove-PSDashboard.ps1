function Remove-PSDashboard {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]$Dashboard
    )
    $URI = Get-URI
    $Header = New-Header
    Return $(Invoke-RestMethod -Method Delete -Headers $Header  -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)).message
}