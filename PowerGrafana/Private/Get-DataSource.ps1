function Get-DataSource {
    param(
        [int]$Id
    )
    $URI = Get-URI
    $Header = New-Header
    $Datasources = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/datasources/" + $Id) 
    return $Datasources
}