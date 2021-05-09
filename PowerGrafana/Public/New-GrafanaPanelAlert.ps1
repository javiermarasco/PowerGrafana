<#

.SYNOPSIS
Creates an alert in a panel.

.DESCRIPTION
This cmdlet will create an alert in a panel, take into consideration you can only have one alert per grafana panel. This alert can have multiple conditions that you can create using the cmdlet 'New-PanelAlertCondition' but the id for each condition can go only from 'A' to

.PARAMETER alertRuleTags
An array of strings that will be used to tag the alert.

.PARAMETER conditions
An array of PowerGrafana.PanelAlertCondition 

.PARAMETER executionErrorState
A string that tells grafana how to handle errors in query or timeouts, this can be either "Alerting" or "Keep Last State", defaults to "Alerting"

.PARAMETER for
The amount of time this alert will be evaluated.

.PARAMETER frequency
How ofther this alert will be executed/evaluated.

.PARAMETER handler

.PARAMETER name
The name of the alert

.PARAMETER noDataState
The definition of what to do in case the metrics are returning no data, this can be:
    no_data: Will set the alert to no_data
    Alerting: Will send an alert
    Keep Last State: Will retain the last status of the alert
    Ok: This will send an status "OK" in case of no data returned from the query in the metric

.PARAMETER notifications
An array of notification channels ids to notify in case the alert is fired.

.EXAMPLE

.NOTES

.LINK

#>
function New-GrafanaPanelAlert {
    param(
    [hashtable]$alertRuleTags = @{},
    [PSTypeName('PowerGrafana.PanelAlertCondition')]
    [hashtable[]]$conditions = (New-PanelAlertCondition),
    [string]$executionErrorState = "alerting",
    [string]$for = "5m",
    [string]$frequency = "1m",
    [string]$handler = 1,
    [string]$name = "Default alert title",
    [string]$noDataState = "no_data",
    [hashtable[]]$notifications = @(@{uid = "XXX-XXXXX"})
    )
    begin {
        $Alert = @{
            alertRuleTags = $alertRuleTags
            conditions = $conditions
            executionErrorState = $executionErrorState
            for = $for
            frequency = $frequency
            handler = $handler
            name = $name
            noDataState = $noDataState
            notifications = $notifications
        }
    }
    process {
        $Alert.PSOBject.TypeNames.Insert(0,'PowerGrafana.PanelAlert')
        return $Alert
    }
}