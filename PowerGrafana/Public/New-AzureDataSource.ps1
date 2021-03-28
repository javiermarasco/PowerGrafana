function New-AzureDataSource {
    param(
        [string]$name,
        [string]$appInsightsAppId,
        [bool]$azureLogAnalyticsSameAs,
        [string]$clientId,
        [string]$cloudName,
        [string]$logAnalyticsClientId,
        [string]$logAnalyticsTenantId,
        [string]$tenantId,
        [string]$appInsightsApiKey,
        [string]$clientSecret,
        [string]$logAnalyticsClientSecret
    )
    $URI = Get-URI
    $Header = New-Header
    $body = @{
        name           = $name
        type           = "grafana-azure-monitor-datasource"
        typeLogoUrl    = "public/app/plugins/datasource/grafana-azure-monitor-datasource/img/logo.jpg"
        access         = "proxy"
        url            = "/api/datasources/proxy/1"
        jsonData       = @{
            azureLogAnalyticsSameAs  = $azureLogAnalyticsSameAs
            clientId                 = $clientId
            tenantId                 = $tenantId
            cloudName                = "azuremonitor"
            logAnalyticsClientId     = $logAnalyticsClientId
            logAnalyticsTenantId     = $logAnalyticsTenantId
            logAnalyticsClientSecret = $logAnalyticsClientSecret
            appInsightsAppId         = $appInsightsAppId
            appInsightsApiKey        = $appInsightsApiKey
        }
        secureJsonData = @{
            clientSecret = $clientSecret
        }
    }

    $Datasources = Invoke-RestMethod -Method Post -Headers $Header -Uri $("$URI/api/datasources") -Body ($body | convertto-json )
    return $Datasources
}