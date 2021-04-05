function Get-GrafanaPanel {

    param (
        [Parameter(Mandatory=$false)] [PSTypeName('PowerGrafana.Panel')] $Panel,
        [Parameter(Mandatory=$false)] $PanelId,
        [Parameter(Mandatory=$false)] $Dashboard,
        [Parameter(Mandatory=$false)] $DashboardId
    )

    #if (![string]::IsNullOrEmpty($Panel.id) -and ![string]::IsNullOrEmpty($Dashboard)  ) {
        $URI = Get-GrafanaURI
        $Header = New-GrafanaHeader

        if ([string]::IsNullOrEmpty($Dashboard)){
            $QueryUri = $("$URI/api/dashboards/uid/" + $DashboardId)
        }else{
            $QueryUri =$("$URI/api/dashboards/uid/" + $Dashboard.uid)
        }
        
        if ([string]::IsNullOrEmpty($Panel)){
            $QueryPanelId = $PanelId
        }else{
            $QueryPanelId = $Panel.id
        }

        $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $QueryUri
        #Write-Output $RetrievedDashboard
        $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $QueryPanelId
        #Write-Output $PanelFound
        # if (![string]::IsNullOrEmpty($Dashboard) ){
        #     $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $Dashboard.uid)
        #     if(![string]::IsNullOrEmpty($Panel)){
        #         if ( $($RetrievedDashboard.dashboard.panels | where-object -property id -eq $Panel.id).count -gt 0) {
        #             $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $Panel.id
        #         }
        #         else {
        #             $PanelFound = $null
        #         }
        #     }else{
        #         if ( $($RetrievedDashboard.dashboard.panels | where-object -property id -eq $PanelId).count -gt 0) {
        #             $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $PanelId
        #         }
        #         else {
        #             $PanelFound = $null
        #         }
        #     }
        # }else{
        #     $RetrievedDashboard = Invoke-RestMethod -Method Get -Headers $Header -Uri $("$URI/api/dashboards/uid/" + $DashboardId)
        #     if(![string]::IsNullOrEmpty($Panel)){
        #         if ( $($RetrievedDashboard.dashboard.panels | where-object -property id -eq $Panel.id).count -gt 0) {
        #             $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $Panel.id
        #         }
        #         else {
        #             $PanelFound = $null
        #         }
        #     }else{
        #         if ( $($RetrievedDashboard.dashboard.panels | where-object -property id -eq $PanelId).count -gt 0) {
        #             $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $PanelId
        #         }
        #         else {
        #             $PanelFound = $null
        #         }
        #     }
        #     # if ( $($RetrievedDashboard.dashboard.panels | where-object -property id -eq $PanelId).count -gt 0) {
        #     #     $PanelFound = $RetrievedDashboard.dashboard.panels | where-object -property id -eq $PanelId
        #     # }
        #     # else {
        #     #     $PanelFound = $null
        #     # }
        # }
        
        $OutputPanel = @{}
        $OutputPanel = $PanelFound | ConvertTo-Json -Depth 8 | ConvertFrom-Json -Depth 8 -AsHashtable
        #$OutputPanel = $PanelFound.psobject.Properties | foreach { $OutputPanel[$_.Name] = $_.Value}
        
        $OutputPanel.PSObject.TypeNames.Insert(0, 'PowerGrafana.Panel')
        return $OutputPanel
    #}

}
        