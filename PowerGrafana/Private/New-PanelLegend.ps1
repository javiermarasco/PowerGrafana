function New-PanelLegend {
    param (
        #[bool]$alignAsTable = $false,
        [bool]$avg = $false,
        [bool]$current = $false,
        #[bool]$hideEmpty = $false,
        #[bool]$hideZero = $false,
        [bool]$max = $false,
        [bool]$min = $false,
        #[bool]$rightSide = $false,
        [bool]$show = $true,
        [bool]$total = $false,
        [bool]$values = $false
    )
    begin {
        $PanelLegend = @{
            #alignAsTable = $alignAsTable
            avg          = $avg
            current      = $current
            #hideEmpty    = $hideEmpty
            #hideZero     = $hideZero
            max          = $max
            min          = $min
            #rightSide    = $rightSide
            show         = $show
            total        = $total
            values       = $values
        }
    }
    process {
        $PanelLegend.PSObject.TypeNames.Insert(0, 'PowerGrafana.PanelLegend')
        return $PanelLegend
    }
    
}