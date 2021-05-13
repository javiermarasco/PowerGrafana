<#

.SYNOPSIS
Creates an alert condition that can be added to an alert.

.DESCRIPTION
The alert conditions in Grafana allows to define when an alert will be fired, this cmdlet allows you to define a single condition. This can be called multiple times to create more conditions for a single alert.

.PARAMETER evaluatorParams
The value used as a threshold for the condition to fire.

.PARAMETER evaluatorType
A definition on when this condition will be triggered, this represents if we will fire the alert when the values is greater than or less than a value, etc. Defaults to "greater than".

.PARAMETER operatorType
A string that defined if this should be evaluated with other conditions as a "and" or "or" logical operation.

.PARAMETER queryParams
An array representing: 
    A letter that represents the query
    A time period to evaluate the alert
    A time ending moment for the evaluation period

.PARAMETER reducerParams
An array of strings representing the reducer parameters in case the reducer type allows parameters, this defaults to an empty array.

.PARAMETER reducerType
This defines the way the condition will evaluate the values, defaults to "avg"

.PARAMETER Type
An string definint the type of the conditions, this defaults to "Query"

.EXAMPLE

.NOTES

.LINK

#>
function New-GrafanaPanelAlertCondition {
    param (
        [int[]]$evaluatorParams = @(200),
        [string]$evaluatorType = "gt",
        [string]$operatorType = "and",
        [string[]]$queryParams = @("A", "15m", "now"),
        [string[]]$reducerParams = @(),
        [string]$reducerType = "avg",
        [string]$Type = "query"
    )
    begin {
        $Condition = @{
            evaluator = @{
                params = $evaluatorParams
                type   = $evaluatorType
            }
            operator  = @{
                type = $operatorType
            }
            query     = @{
                params = $queryParams
            }
            reducer   = @{
                params = $reducerParams
                type   = $reducerType
            }
            type      = $Type
        }
    }

    process {
        $Condition.PSOBject.TypeNames.Insert(0, 'PowerGrafana.PanelAlertCondition')
        return $Condition
    }
    
}