function Get-GrafanaDashboard {
    param (
        [Parameter(Mandatory=$false)]$DashboardId,
        [Parameter(Mandatory=$false)]$Dashboard
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader
    if (![string]::IsNullOrEmpty($Dashboard) ){
        $RetrievedDashboard = $(Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)).dashboard
    }else{
        $RetrievedDashboard = $(Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $DashboardId)).dashboard
    }
    
    $RetrievedDashboard.PSObject.TypeNames.Insert(0, 'PowerGrafana.Dashboard')
    return $RetrievedDashboard
}