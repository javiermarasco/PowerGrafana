function Get-DataSources {
    $URI = Get-URI
    $Header = New-Header
    $Datasources = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/datasources") 
    return $Datasources
}