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
