function New-GrafanaPanelTargetAzureInsightsAnalytics {
    param (
        [string]$query = "",
        [string]$resultFormat = "time_series",
        [parameter(Mandatory=$true)][string]$dataSourceName,
        [parameter(mandatory=$true)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [parameter(mandatory=$true)]$Dashboard

    )
    $insightsAnalytics = @{
        query = $query
        resultFormat = $resultFormat
    }
    $insightsAnalytics.PSObject.TypeNames.Insert(0,'PowerGrafana.PanelTargetInsightsAnalytics')
    $PanelFromGrafana = Get-PSPanel -Panel $Panel -Dashboard $Dashboard
    if ($null -ne $PanelFromGrafana.targets){
        $PanelTargets = $PanelFromGrafana.targets
    }else{
        $PanelTargets = @()
    }

    $NewAzureTarget = New-PanelTargetAzure
    $NextAvailableRefId = Get-NextAvailableRefId -Panel $PanelFromGrafana -Dashboard $Dashboard

    if ($NextAvailableRefId -eq -1){
        Write-Output "Panel can't have more targets, maximum targets reached."
    }else{
        $NewAzureTarget.refId = $NextAvailableRefId
        $NewAzureTarget.insightsAnalytics = $insightsAnalytics
        $PanelTargets += $NewAzureTarget
        $Panel.datasource = $dataSourceName
        if($null -eq $Panel.target){
            $Panel += @{"targets" = $PanelTargets}
        }else{
            $Panel.targets = $PanelTargets
        }
        
        $Panel.PSObject.TypeNames.Insert(0, 'PowerGrafana.Panel')
    }
    return  $Panel
}