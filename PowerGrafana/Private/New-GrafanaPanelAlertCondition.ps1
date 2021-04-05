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
        $Condition.PSOBject.TypeNames.Insert(0,'PowerGrafana.PanelAlertCondition')
        return $Condition
    }
    
}