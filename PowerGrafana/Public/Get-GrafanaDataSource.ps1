function Get-GrafanaDataSource {
    param(
        [int]$Id
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader
    if($Id){
        $Datasources = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/datasources/" + $Id) 
    }else{
        $Datasources = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/datasources") 
    }
    return $Datasources
}