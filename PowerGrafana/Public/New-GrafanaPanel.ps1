<#

.SYNOPSIS
Creates a panel in grafana.

.DESCRIPTION
This cmdlet will create a panel in Grafana with default values if they are not specified but it is also fully configurable to specify all the parameters that a Grafana panel supports.

.PARAMETER alert
A PowerGrafana.PanelAlert object that specifies the alert to be fired by this panel, this can be set as null if no alerts are needed.

.PARAMETER aliasColors
An array of hashtables with "name of series": "hex color for that series"

.PARAMETER bars
A boolean that specifies if we want to show the graph in the panel as bars.

.PARAMETER dashLength
Specifies the lenght of the dashes if we define "dashes" as true.

.PARAMETER dashes
A boolean that specifies if we want to represent the graph as a dashed line.

.PARAMETER datasource
A datasource object that can be retrieved with "Get-GrafanaDataSource" or created with "New-GrafanaDataSource"

.PARAMETER fieldConfig
A "PowerGrafana.PanelFieldConfig" defining the field config for the panel.

.PARAMETER fill
An integer representing the opacity of the filling in the graph.

.PARAMETER fillGradient
An integer representing the gradient for the fill

.PARAMETER gridPos
A "PowerGrafana.PanelGridPos" object that defines where the panel will be placed inside the dashboard.

.PARAMETER hiddenSeries
A boolean that specifies if the series should be hidden or not, this defaults to false, making the series visible.

.PARAMETER id
The id of the panel, 

.PARAMETER legend
An object representing the legend panel for this panel.

.PARAMETER lines
A boolean that specifies if the series will be represented as a line.

.PARAMETER linewidth
An integre that define the width of the line in case we define "lines" as true.

.PARAMETER nullPointMode
A string that represents what to display in case of a null point, this can be "connected", "null" or "null as zero"

.PARAMETER options
A hashtable that represent if "alertThreshold" should be enabled or not.

.PARAMETER percentage
A boolean that defines if the values whould be represented as percentages in case "Stack" is set to true.

.PARAMETER pluginVersion
The version of the plugin we are using in the panel.

.PARAMETER pointradius
An integer defininig the radius of each point in case we define "points" as true.

.PARAMETER points
A boolean to define if we want to present the series as points.

.PARAMETER renderer
A string that defines the renderer, this defaults to "flot".

.PARAMETER seriesOverrides
A regular expression used to specify the override of values in the panel.

.PARAMETER spaceLength
An integer representing the space 

.PARAMETER stack
A boolean value to specify if we want to stack the graphs in the panel.

.PARAMETER steppedLine
A boolean to define if we want 

.PARAMETER targets
An array of PowerGrafana.Targets that will be presented in the panel.

.PARAMETER thresholds
A hashtable containing "colorMode", "fill", "line", "op" and "value"

.PARAMETER timeFrom
Specifies the starting time for the panel, this defaults to null to allow the panel to be using the dashboard time frame.

.PARAMETER timeRegions
An array of Hash tables to specify coloring of a region in the panel.

.PARAMETER timeShift
This parameter defaults to "null"

.PARAMETER title
The title of the panel.

.PARAMETER tooltip
The tooltip to show when hovering ovet the panel.

.PARAMETER type
A string defininf the type of panel, this is what is presented in the "Visualization" area of the panel in the grafana web interface.

.PARAMETER xaxis
A "PowerGrafana.PanelXAxis" object defining the values for the X axis.

.PARAMETER yaxes
An array of "PowerGrafana.PanelYAxes" objects that define the values for the y axes.

.PARAMETER yaxis
A "PowerGrafana.PanelYAxis" object representing the values for the Y axis.

.PARAMETER Dashboard
A PowerGrafana.Dashboard object which will be used to place this panel.

.EXAMPLE

.NOTES

.LINK

#>
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