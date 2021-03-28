function New-PanelTargetAppInsights {
    param (
        [string[]]$dimension = @(),
        [string]$metricName = "select",
        [string]$timeGrain = "auto"
    )
    begin{
        $AppInsights = @{
            dimension = $dimension
            metricName = $metricName
            timeGrain = $timeGrain
        }
    }
    process{
        $AppInsights.PSObject.TypeNames.Insert(0,'PowerGrafana.PanelTargetAppInsights')
        return $AppInsights
    }
    
}