function New-PanelFieldconfig {
    param (
        [hashtable]$defaults = @{
            custom = @{}
        },
        [string[]]$overrides = @()
    )
    begin {
        $FieldConfig = @{
            defaults  = $defaults
            overrides = $overrides
        }
    }
    process {
        $FieldConfig.PSObject.TypeNames.Insert(0, 'PowerGrafana.PanelFieldconfig')
        return $FieldConfig
    }
    
}