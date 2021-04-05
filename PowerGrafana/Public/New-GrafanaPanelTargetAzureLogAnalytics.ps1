function New-GrafanaPanelTargetAzureLogAnalytics {
    param (
        [string]$query = "",
        [string]$resultFormat = "time_series",
        [string]$workspace = "",
        [parameter(Mandatory=$true)][string]$dataSourceName,
        [parameter(mandatory=$true)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [parameter(mandatory=$true)]$Dashboard

    )
    $logAnalytics = @{
        query = $query
        resultFormat = $resultFormat
        workspace = $workspace
    }
    $logAnalytics.PSObject.TypeNames.Insert(0,'PowerGrafana.PanelTargetAzureLogAnalytics')
    $PanelFromGrafana = Get-GrafanaPanel -Panel $Panel -Dashboard $Dashboard
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
        $NewAzureTarget.logAnalytics = $logAnalytics
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