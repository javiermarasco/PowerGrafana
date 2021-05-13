function New-PanelLegend {
    param (
        [bool]$avg = $false,
        [bool]$current = $false,
        [bool]$max = $false,
        [bool]$min = $false,
        [bool]$show = $true,
        [bool]$total = $false,
        [bool]$values = $false
    )
    begin {
        $PanelLegend = @{
            avg     = $avg
            current = $current
            max     = $max
            min     = $min
            show    = $show
            total   = $total
            values  = $values
        }
    }
    process {
        $PanelLegend.PSObject.TypeNames.Insert(0, 'PowerGrafana.PanelLegend')
        return $PanelLegend
    }
    
}