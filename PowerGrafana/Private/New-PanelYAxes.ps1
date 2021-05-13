function New-PanelYAxes {
    param (
        [string]$format = "short",
        [pscustomobject]$label = $null,
        [int]$logBase = 1,
        [pscustomobject]$max = $null,
        [pscustomobject]$min = $null,
        [bool]$show = $true
    )
    begin {
        $PanelYAxes = @{
            format  = $format
            label   = $label
            logBase = $logBase
            max     = $max
            min     = $min
            show    = $show
        }
    }
    process {
        $PanelYAxes.PSObject.TypeNames.Insert(0, 'PowerGrafana.PanelYAxes')
        return $PanelYAxes
    }
    
}