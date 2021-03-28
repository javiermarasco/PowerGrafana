function New-PanelAlert {
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