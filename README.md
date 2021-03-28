# PowerGrafana

# Example

Remember to set up the following in your environment
 - $env:POWERGRAFANA_TOKEN = "" # With the API token for your grafana instance
 - $env:POWERGRAFANA_URI = "" # With the url to your grafana instance

## Create a DataSource for Azure Monitor

It is possible to create an Azure Monitor datasource with the following cmdlet. If the `azureLogAnalyticsSameAs` is set to false, the following values needs to be provided:


* logAnalyticsClientId
* logAnalyticsTenantId
* logAnalyticsClientSecret

If `appInsights` is needed you also need to provide the following values:

* appInsightsAppId
* appInsightsApiKey

```powershell
$Datasource = New-AzureDataSource -name "azure" `
                                  -clientId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" `
                                  -clientSecret "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" `
                                  -tenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" `
                                  -azureLogAnalyticsSameAs $false 
```

## Create a dashboard

A simple empty dashboard can be created with the following cmdlet
``` powershell
# Create dashboard
$Dashboard = New-PSDashboard -DashboardName "Dashboard"
```

## Panel management

The addition of panels to a dashboard is done in two steps, first we need to create the panel using `New-PSPanel` and then we need to add the panel to the dashboard using `Add-PSPanel`. This can be done multiple times when you need multiple panels, but you must run first `New-PSPanel` and then `Add-PSPanel` for each panel.

```powershell
# Create an empty panel
$Panel0 = New-PSPanel -Dashboard $Dashboard

# Optionally create more panels
# $Panel1 = New-PSPanel -Dashboard $Dashboard
# Add-PSPanel -Dashboard $Dashboard -Panel $Panel1

# Add the panel to the dashboard
Add-PSPanel -Dashboard $Dashboard -Panel $Panel0
```

## Target management

To display metrics inside a panel it is needed to create a target, each target is a metric specific item, it means that you will need a target per resource AND per metric that you want to monitor, to create the target you use `New-PSPanelTargetAzureMonitor` and after the target is configured you need to add it to the panel using `Update-PSDashboardPanel`

- DatasourceName is an string, you can provide the value from the creation of the datasource or the name of the datasource if you know it.



```powershell
# Create a target 
$PanelWithTarget0 = New-PSPanelTargetAzureMonitor -Panel $Panel0 `
    -Dashboard $Dashboard `
    -resourceGroup "AzureResourceGroup" `
    -resourceName "AzureResourceName" `
    -metricName "CpuTime" `
    -metricNamespace "Microsoft.Web/sites" `
    -metricDefinition "Microsoft.Web/sites" `
    -dataSourceName $Datasource.datasource.name

# Add the target to the panel
Update-PSDashboardPanel -Panel $PanelWithTarget0 -Dashboard $Dashboard
```
In the same way as with panels, if you want to create multiple targets in a single panel it is possible, but you need to run `New-PSPanelTargetAzureMonitor` and then `Update-PSDashboardPanel` for each target that you want to add into the panel.

Keep in mind that there is a maximum of 24 targets per panel, when you reach the maximum the `New-PSPanelTargetAzureMonitor` will fail and let you know you reached the maximum number of targets for the given panel.


## Remove dashboards

It is also possible to delete a coplete dashboard, this is simply done by calling `Remove-PSDashboard` and providing the name of the dashboard, this will delete the complete dashboard without asking but will not change any datasource.

All alerts defined in the dashboard are gonna be deleted as well.

```powershell
# Remove a dashboard
Remove-PSDashboard -Dashboard $Dashboard
```

# TODO

* Alerts : Alert management needs to be added
* Pipelining commands : Add support to pipeline une cmdlet to another one to make it easier to use
* Notification channels: Add cmdlet to manage the creation and deletion of them.
* Create powershell gallery account (DONE)
  * Follow this -> https://jeffbrown.tech/how-to-publish-your-first-powershell-gallery-package/
* Create Azure DevOps pipeline to build, test and publish to PSGallery
* Define a license to use for the project

