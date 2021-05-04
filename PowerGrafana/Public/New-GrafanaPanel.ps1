function New-GrafanaPanel {
    param (
        [PSTypeName('PowerGrafana.PanelAlert')]
        [pscustomobject]$alert = $null,
        [hashtable]$aliasColors = @{},
        [bool]$bars = $false,
        [int]$dashLength = 10,
        [bool]$dashes = $false,
        [pscustomobject]$datasource = $null,
        [PSTypeName('PowerGrafana.PanelFieldConfig')]
        [hashtable]$fieldConfig = (New-PanelFieldConfig),
        [int]$fill = 1,
        [int]$fillGradient = 0,
        [PSTypeName('PowerGrafana.PanelGridPos')]
        [hashtable]$gridPos = (New-PanelGridPos),
        [bool]$hiddenSeries = $false,
        [int]$id = 0,
        [PSTypeName('PowerGrafana.PanelLegend')]
        [hashtable]$legend = (New-PanelLegend),
        [bool]$lines = $true,
        [int]$linewidth = 1,
        [string]$nullPointMode = "null",
        [hashtable]$options = @{
            alertThreshold = $true 
        },
        [bool]$percentage = $false,
        [string]$pluginVersion = "7.3.6",
        [int]$pointradius = 2,
        [bool]$points = $false,
        [string]$renderer = "flot",
        [string[]]$seriesOverrides = @(),
        [int]$spaceLength = 10,
        [bool]$stack = $false,
        [bool]$steppedLine = $false,
        [PSTypeName('PowerGrafana.PanelTarget')]
        [pscustomobject]$targets = $null,
        [string[]]$thresholds = @(),
        [pscustomobject]$timeFrom = $null,
        [string[]]$timeRegions = @(),
        [pscustomobject]$timeShift = $null,
        [string]$title = "Panel Title",
        [PSTypeName('PowerGrafana.PanelTooltip')]
        [hashtable]$tooltip = (New-PanelTooltip),
        [string]$type = "graph",
        [PSTypeName('PowerGrafana.PanelXAxis')]
        [hashtable]$xaxis = (New-PanelXAxis),
        [PSTypeName('PowerGrafana.PanelYAxes')]
        [hashtable[]]$yaxes = @($(New-PanelYAxes), $(New-PanelYAxes) ),
        [PSTypeName('PowerGrafana.PanelYAxis')]
        [hashtable]$yaxis = (New-PanelYAxis),
        [Parameter(Mandatory = $true)]$Dashboard
    )
    begin {
        $Panel = @{
            #h                = $h
            #w                = $w
            #x                = $x
            #y                = $y
            #alert           = $alert
            aliasColors     = $aliasColors
            bars            = $bars
            dashLength      = $dashLength
            dashes          = $dashes
            datasource      = $datasource
            fieldConfig     = $fieldConfig
            fill            = $fill
            fillGradient    = $fillGradient
            gridPos         = $gridPos
            hiddenSeries    = $hiddenSeries
            id              = $id
            legend          = $legend
            lines           = $lines
            linewidth       = $linewidth
            nullPointMode   = $nullPointMode
            options         = $options
            percentage      = $percentage
            pluginVersion   = $pluginVersion
            pointradius     = $pointradius
            points          = $points
            renderer        = $renderer
            seriesOverrides = $seriesOverrides
            spaceLength     = $spaceLength
            stack           = $stack
            steppedLine     = $steppedLine
            #targets         = $targets
            thresholds      = $thresholds
            timeFrom        = $timeFrom
            timeRegions     = $timeRegions
            timeShift       = $timeShift
            title           = $title
            tooltip         = $tooltip
            type            = $type
            xaxis           = $xaxis
            yaxes           = $yaxes
            yaxis           = $yaxis
        }
        if ($null -ne $alert) {
            $Panel += @{"alert" = $alert }
        }
        if ($null -ne $targets) {
            $Panel += @{"targets" = $targets }
        }

    }
    process {
        $Panel.PSObject.TypeNames.Insert(0, 'PowerGrafana.Panel')
        $Panel.id = Get-NextAvailablePanelId -Dashboard $Dashboard
        return $Panel
    }
    
}