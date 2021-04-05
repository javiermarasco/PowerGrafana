function New-GrafanaPanelTargetAzureAppInsights {
    param (
        [string[]]$dimension = @(),
        [string]$metricName = "select",
        [string]$timeGrain = "auto",
        [parameter(Mandatory=$true)][string]$dataSourceName,
        [parameter(mandatory=$true)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [parameter(mandatory=$true)]$Dashboard

    )
    $AzureAppInsights = @{
        dimension = $dimension
        metricName = $metricName
        timeGrain = $timeGrain
    }
    $AzureAppInsights.PSObject.TypeNames.Insert(0,'PowerGrafana.PanelTargetAppInsights')
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
        $NewAzureTarget.appInsights = $AzureAppInsights
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