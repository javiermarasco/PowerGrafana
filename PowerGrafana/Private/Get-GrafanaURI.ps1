function Get-GrafanaURI {
    if ([string]::IsNullOrEmpty($Env:POWERGRAFANA_URI)) {
        throw "POWERGRAFANA_URI environment variable is not defined"
    }
    else {
        $URI = get-content ENV:\POWERGRAFANA_URI
        return $URI
    }
}