function New-PanelTargetAzure {
    param (
        [PSTypeName('PowerGrafana.PanelTargetAppInsights')]
        [hashtable]$appInsights = (New-PanelTargetAppInsights),
        [PSTypeName('PowerGrafana.PanelTargetAzureLogAnalytics')]
        [hashtable]$azureLogAnalytics = (New-PanelTargetAzureLogAnalytics),
        [PSTypeName('PowerGrafana.PanelTargetAzureMonitor')]
        [hashtable]$azureMonitor, # = (New-PSPanelTargetAzureMonitor),
        [PSTypeName('PowerGrafana.PanelTargetInsightsAnalytics')]
        [hashtable]$insightsAnalytics = (New-PanelTargetInsightsAnalytics),
        [string]$queryType = "Azure Monitor",
        [string]$refId = ""
        #,        [string]$subscription = ""
    )
    begin {
        $Target = @{
            appInsights       = $appInsights
            azureLogAnalytics = $azureLogAnalytics
            azureMonitor      = $azureMonitor
            insightsAnalytics = $insightsAnalytics
            queryType         = $queryType
            refId             = $refId
            #subscription      = $subscription
        }
    }

    process {
        $Target.PSOBject.TypeNames.Insert(0, 'PowerGrafana.PanelTarget')
        return $Target
    }
    
}