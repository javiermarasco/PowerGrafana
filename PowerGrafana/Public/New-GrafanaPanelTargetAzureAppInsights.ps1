<#

.SYNOPSIS
Creates a target for Azure Application Insights.

.DESCRIPTION
This cmdlet will create a target and add it to a provided panel, the letter representing the RefId of the target is automatically assigned starting with the letter "A" up to "Z", if more targets are added this cmdlet will return "Panel can't have more targets, maximum targets reached" in which case another panel needs to be created to add the targets.

.PARAMETER dimension
An array of strings defining the dimensions that we want to setup in this target.

.PARAMETER metricName
The name of the metric.

.PARAMETER timeGrain
A string representing the way the target will group the metrics, this defaults to "auto"

.PARAMETER dataSourceName
A string representing the name of the datasource that will provide the access to metrics for this target.

.PARAMETER Panel
A PowerGrafana.Panel where this target will be added.

.PARAMETER Dashboard
The dasboard where the panel containing this target is, this is represented with a PowerGrafana.Dashboard object.


.EXAMPLE

.NOTES

.LINK
New-GrafanaDashboard
Get-GrafanaDashboard
New-GrafanaPanel
Get-GrafanaPanel
Get-GrafanaDataSource

#>
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