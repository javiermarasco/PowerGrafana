function New-PanelYAxis {
    param (
        [bool]$align = $false,
        [pscustomobject]$alignLevel = $null
    )
    begin {
        $PanelYAxis = @{
            align      = $align
            alignLevel = $alignLevel
        }
    }
    process {
        $PanelYAxis.PSObject.TypeNames.Insert(0, 'PowerGrafana.PanelYAxis')
        return $PanelYAxis
    }
    
}