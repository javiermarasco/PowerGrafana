function New-PanelXAxis {
    param (
        [pscustomobject]$buckets = $null,
        [string]$mode = "time",
        [pscustomobject]$name = $null,
        [bool]$show = $true,
        [string[]]$values = @()
    )
    begin {
        $PanelXAxis = @{
            buckets = $buckets
            mode    = $mode
            name    = $name
            show    = $show
            values  = $values
        }
    }
    process {
        $PanelXAxis.PSObject.TypeNames.Insert(0, 'PowerGrafana.PanelXAxis')
        return $PanelXAxis
    }
    
}