function New-PanelTargetAzure {
    param (
        [PSTypeName('PowerGrafana.PanelTargetAppInsights')]
        [hashtable]$appInsights, 
        [PSTypeName('PowerGrafana.PanelTargetAzureLogAnalytics')]
        [hashtable]$logAnalytics, 
        [PSTypeName('PowerGrafana.PanelTargetAzureMonitor')]
        [hashtable]$monitor, 
        [PSTypeName('PowerGrafana.PanelTargetInsightsAnalytics')]
        [hashtable]$insightsAnalytics, 
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