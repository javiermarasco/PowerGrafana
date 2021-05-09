<#

.SYNOPSIS
Creates an Azure datasource in Grafana

.DESCRIPTION
This cmdlet will create an Azure datasource in Grafana using the provided configuration.

.PARAMETER name
The name of the datasource to create

.PARAMETER appInsightsAppId
The application id of our Application Insights instance in Azure.

.PARAMETER azureLogAnalyticsSameAs
This is a flag to determine if the Log Analytics configuration is the same as the one used for Azure Monitor, setting this to True will allow to not provide a configuration for Log Analytics items.

.PARAMETER clientId
The client id of the Service Principal used in Azure to manage the resources.

.PARAMETER cloudName


.PARAMETER logAnalyticsClientId
The client id of our log analytics workspace instance in Azure.

.PARAMETER logAnalyticsClientSecret
The secret of our log analytics workspace instance

.PARAMETER logAnalyticsTenantId
The tenant id of the Azure Active Directory where our log analytics workspace instance is deployed.

.PARAMETER tenantId
The tenant id where the Azure resources are deployed.

.PARAMETER appInsightsApiKey
The applications insights instrumentation key.

.PARAMETER clientSecret
The secret key of the Service Principal used to manage our resources in Azure.

.EXAMPLE

.NOTES

.LINK

#>
function New-GrafanaAzureDataSource {
    param(
        [string]$name,
        [string]$appInsightsAppId,
        [bool]$azureLogAnalyticsSameAs,
        [string]$clientId,
        [string]$cloudName,
        [string]$logAnalyticsClientId,
        [string]$logAnalyticsClientSecret,
        [string]$logAnalyticsTenantId,
        [string]$tenantId,
        [string]$appInsightsApiKey,
        [string]$clientSecret
    )
    $URI = Get-GrafanaURI
    $Header = New-GrafanaHeader
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