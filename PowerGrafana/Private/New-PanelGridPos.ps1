function New-PanelGridPos {
    param (
        [int]$h = 5,
        [int]$w = 10,
        [int]$x = 0,
        [int]$y = 0
    )
    begin{
        $GridPos = @{
            h = $h
            w = $w
            x = $x
            y = $y
        }
    }
    process{
        $GridPos.PSObject.TypeNames.Insert(0,'PowerGrafana.PanelGridPos')
        return $GridPos
    }
    
}