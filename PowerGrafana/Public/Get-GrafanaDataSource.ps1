<#

.SYNOPSIS
Retrieves a datasource from Grafana by it's Id or a list of all datasources if no Id is provided.

.DESCRIPTION
By providing an Id as a parameter to this cmdlet you will get a datasource that can be later be used in targets, if you Id is provided it will return a list of datasources.

.PARAMETER Id
The DataSource id provided as a numeric value.

.EXAMPLE
Get-GrafanaDataSource -Id 2

.NOTES

.LINK

#>
function Get-GrafanaDataSource {
    param(
        [int]$Id
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader
    if ($Id) {
        $Datasources = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/datasources/" + $Id) 
    }
    else {
        $Datasources = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/datasources") 
    }
    return $Datasources
}