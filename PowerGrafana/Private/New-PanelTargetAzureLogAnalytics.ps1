function New-PanelTargetAzureLogAnalytics {
    param (
        [string]$query = "",
        [string]$resultFormat = "time_series",
        [string]$workspace = ""
    )
    begin{
        $AzureLogAnalytics = @{
            query = $query
            resultFormat = $resultFormat
            workspace = $workspace
        }
    }
    process{
        $AzureLogAnalytics.PSObject.TypeNames.Insert(0,'PowerGrafana.PanelTargetAzureLogAnalytics')
        return $AzureLogAnalytics
    }
    
}