function New-PanelTooltip {
    param (
        [bool]$shared = $true,
        [int]$sort = 0,
        [string]$value_type = "individual"
    )
    begin{
        $PanelTooltip = @{
            shared = $shared
            sort = $sort
            value_type = $value_type
        }
    }
    process{
        $PanelTooltip.PSObject.TypeNames.Insert(0,'PowerGrafana.PanelTooltip')
        return $PanelTooltip
    }
    
}