<#

.SYNOPSIS
Creates a target for Azure Insights Analytics

.DESCRIPTION
This cmdlet will create a target for Insights Analytics in a provided panel

.PARAMETER query
This is a string representing the query to execute in Insights Analytics.

.PARAMETER resultFormat
A string representing the format of the result returned by the query, this defaults to "time_series".

.PARAMETER dataSourceName
A string representing the name of the datasource that will provide the access to metrics for this target.

.PARAMETER Panel
A PowerGrafana.Panel where this target will be added.

.PARAMETER Dashboard
The dasboard where the panel containing this target is, this is represented with a PowerGrafana.Dashboard object.

.EXAMPLE

.NOTES

.LINK

#>
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