<#

.SYNOPSIS
Creates a target to run queries to a Log Analytics Workspace.

.DESCRIPTION
This cmdlet will create a target to query a Log Analytics Workspace.

.PARAMETER query
This is a string representing the query to execute in the Log Analytics Workspace.

.PARAMETER resultFormat
A string representing the format of the result returned by the query, this defaults to "time_series".

.PARAMETER workspace
A string representing the workspace name of the Log Analytics workspace

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
function New-GrafanaPanelTargetAzureLogAnalytics {
    param (
        [string]$query = "",
        [string]$resultFormat = "time_series",
        [string]$workspace = "",
        [parameter(Mandatory = $true)][string]$dataSourceName,
        [parameter(mandatory = $true)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [parameter(mandatory = $true)]$Dashboard

    )
    $logAnalytics = @{
        query        = $query
        resultFormat = $resultFormat
        workspace    = $workspace
    }
    $logAnalytics.PSObject.TypeNames.Insert(0, 'PowerGrafana.PanelTargetAzureLogAnalytics')
    $PanelFromGrafana = Get-GrafanaPanel -Panel $Panel -Dashboard $Dashboard
    if ($null -ne $PanelFromGrafana.targets) {
        $PanelTargets = $PanelFromGrafana.targets
    }
    else {
        $PanelTargets = @()
    }

    $NewAzureTarget = New-PanelTargetAzure
    $NextAvailableRefId = Get-NextAvailableRefId -Panel $PanelFromGrafana -Dashboard $Dashboard

    if ($NextAvailableRefId -eq -1) {
        Write-Output "Panel can't have more targets, maximum targets reached."
    }
    else {
        $NewAzureTarget.refId = $NextAvailableRefId
        $NewAzureTarget.logAnalytics = $logAnalytics
        $PanelTargets += $NewAzureTarget
        $Panel.datasource = $dataSourceName
        if ($null -eq $Panel.target) {
            $Panel += @{"targets" = $PanelTargets }
        }
        else {
            $Panel.targets = $PanelTargets
        }
        
        $Panel.PSObject.TypeNames.Insert(0, 'PowerGrafana.Panel')
    }
    return  $Panel
}