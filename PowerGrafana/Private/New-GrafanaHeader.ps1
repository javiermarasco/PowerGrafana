function New-GrafanaHeader {
    if ([string]::IsNullOrEmpty($Env:POWERGRAFANA_TOKEN)) {
        throw "POWERGRAFANA_TOKEN environment variable is not defined"
    }
    else {
        $Token = get-content ENV:\POWERGRAFANA_TOKEN
        $Header = @{
            Authorization  = "Bearer " + $Token
            "Content-Type" = "application/json"
        }
        return $Header
    }
}