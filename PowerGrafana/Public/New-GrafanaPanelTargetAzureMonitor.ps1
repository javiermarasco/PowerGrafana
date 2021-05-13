<#

.SYNOPSIS
Creates an Azure Monitor target for a given panel.

.DESCRIPTION
This cmdlet will create an Azure Monitor target to be placed in a panel in Grafana, it allows the configuration of all the values up to version.

.PARAMETER aggOptions
An array of strings containing the possible aggregation options for the target, those can be "None", "Average", "Minimum", "Maximum", "Total" and "Count".
            
.PARAMETER aggregation
A string that selects what is the aggregation to show, this needs to be a value that is defined in the "aggOptions"

.PARAMETER alias
A string to name this target with an alias.

.PARAMETER allowedTimeGrainsMs
An array of integers that represents the available time grains for the target, those values can be: 60000, 300000, 900000, 1800000, 3600000, 21600000, 43200000, 86400000.

.PARAMETER dimensionFilter
An string defining what dimension to use for the filterin, this defaults to "*" meaning all dimensions are used as filter.

.PARAMETER dimensionFilters
An array of strings that defines the possible dimensions for the target.

.PARAMETER dimensions
An array of hashtables where on each hastable it is defined the "text" and "value" of each dimension we want to use in the target.

.PARAMETER metricDefinition
A string that defines the metric namespace

.PARAMETER metricName
A string that specify the name of the metric to use

.PARAMETER metricNamespace
A string that specify the name of the metric namespace where the metric we choose belongs.

.PARAMETER resourceGroup
A string that specify the resource group name where the resource is deployed.

.PARAMETER resourceName
A string that specify the name of the resource we want to monitog. 

.PARAMETER timeGrain
An string defining which time grain to use, this needs to be one of the values "text" in the "timeGrains" option. Defaults to Auto.

.PARAMETER timeGrains
An array of hashtables that define the possible time grains to present the metric time, each hashtable needs to have a "text" and "value" item with the following values: 
                text  = "auto"
                value = "auto"

                text  = "1 minute"
                value = "PT1M"

                text  = "5 minute"
                value = "PT5M"

                text  = "15 minute"
                value = "PT15M"

                text  = "30 minute"
                value = "PT30M"

                text  = "1 hour"
                value = "PT1H"

                text  = "6 hour"
                value = "PT6H"

                text  = "12 hour"
                value = "PT12H"

                text  = "1 day"
                value = "P1D"

.PARAMETER top
An integer defining how many entries to show as top.

.PARAMETER dataSourceName
A string representing the name of the datasource that will provide the access to metrics for this target.

.PARAMETER Panel
A PowerGrafana.Panel where this target will be added.

.PARAMETER Dashboard
A PowerGrafana.Dashboard object which will be used to place this panel.

.EXAMPLE

.NOTES

.LINK

#>
function New-GrafanaPanelTargetAzureMonitor {
    param (
        [parameter(mandatory=$false)][string[]]$aggOptions = 
        @(
            "None"
            "Average"
            "Minimum"
            "Maximum"
            "Total"
            "Count"
        ),
        [parameter(mandatory=$false)]$aggregation = "Total",
        [parameter(mandatory=$false)]$alias = $null,
        [parameter(mandatory=$false)][int[]]$allowedTimeGrainsMs = 
        @(
            60000
            300000
            900000
            1800000
            3600000
            21600000
            43200000
            86400000
        ),
        [parameter(mandatory=$false)][string]$dimensionFilter = "*",
        [parameter(mandatory=$false)][string[]]$dimensionFilters = @(),
        [parameter(mandatory=$false)][hashtable[]]$dimensions = 
        @(
            @{
                text  = "Instance"
                value = "Instance"
            }
        ),
        [parameter(mandatory=$false)][string]$metricDefinition = "select",
        [parameter(mandatory=$false)][string]$metricName = "select",
        [parameter(mandatory=$false)][string]$metricNamespace = "select",
        [parameter(mandatory=$false)][string]$resourceGroup = "select",
        [parameter(mandatory=$false)][string]$resourceName = "select",
        [parameter(mandatory=$false)][string]$timeGrain = "auto",
        [parameter(mandatory=$false)][hashtable[]]$timeGrains = 
        @(
            @{
                text  = "auto"
                value = "auto"
            },
            @{
                text  = "1 minute"
                value = "PT1M"
            },
            @{
                text  = "5 minute"
                value = "PT5M"
            },
            @{
                text  = "15 minute"
                value = "PT15M"
            },
            @{
                text  = "30 minute"
                value = "PT30M"
            },
            @{
                text  = "1 hour"
                value = "PT1H"
            },
            @{
                text  = "6 hour"
                value = "PT6H"
            },
            @{
                text  = "12 hour"
                value = "PT12H"
            },
            @{
                text  = "1 day"
                value = "P1D"
            }
        ),
        [parameter(mandatory=$false)][string]$top = "10",
        [parameter(Mandatory=$true)][string]$dataSourceName,
        [parameter(mandatory=$true)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [parameter(mandatory=$true)]$Dashboard
    )
        $AzureMonitor = @{
            aggOptions = $aggOptions
            aggregation = $aggregation
            alias = $alias
            allowedTimeGrainsMs = $allowedTimeGrainsMs
            dimensionFilter = $dimensionFilter
            dimensionFilters = $dimensionFilters
            dimensions = $dimensions
            metricName = $metricName
            metricNamespace = $metricNamespace
            resourceGroup = $resourceGroup
            resourceName = $resourceName
            timeGrain = $timeGrain
            timeGrains = $timeGrains
            top = $top
        }
        if(![string]::IsNullOrEmpty($metricDefinition)){
            $AzureMonitor.metricDefinition = $metricDefinition
        }else{
            $AzureMonitor.metricDefinition = $metricNamespace
        }

        # if ($null -ne $aggregation){
        #     $AzureMonitor += @{"aggregation" = $aggregation}
        # }
        # if ($null -ne $alias){
        #     $AzureMonitor += @{"alias" = $alias}
        # }
        # if ($null -ne $allowedTimeGrainsMs){
        #     $AzureMonitor += @{"allowedTimeGrainsMs" = $allowedTimeGrainsMs}
        # }
        # if ($null -ne $dimensions){
        #     $AzureMonitor += @{"dimensions" = $dimensions}
        # }
        # if ($null -ne $timeGrains){
        #     $AzureMonitor += @{"timeGrains" = $timeGrains}
        # }

        $AzureMonitor.PSOBject.TypeNames.Insert(0,'PowerGrafana.PanelTargetAzureMonitor')
    

        #$PanelTarget  = New-PanelTargetAzure 

        #$NewPanel = New-PanelTargetAzure
        # The RefId is of the target, not the panel
        # This function needs to create a target and append to the targets array of the given panel

        # If the panel has targets, we extract them to add the new target
        
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
            $NewAzureTarget.monitor = $AzureMonitor
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
