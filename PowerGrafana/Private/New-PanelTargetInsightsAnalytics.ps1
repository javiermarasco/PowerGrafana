function New-PanelTargetInsightsAnalytics {
    param (
        [string]$query = "",
        [string]$resultFormat = "time_series"
    )
    begin{
        $InsightsAnalytics = @{
            query = $query
            resultFormat = $resultFormat
        }
    }
    process{
        $InsightsAnalytics.PSObject.TypeNames.Insert(0,'PowerGrafana.PanelTargetInsightsAnalytics')
        return $InsightsAnalytics
    }
}