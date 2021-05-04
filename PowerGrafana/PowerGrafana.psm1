$Public = Get-ChildItem -Path $PSScriptRoot\Public\*.ps1
$Private = Get-ChildItem -Path $PSScriptRoot\Private\*.ps1

$AllFunctions = @($Public + $Private)
foreach ($Function in $AllFunctions) {
    try {
        . $Function.fullname
    }
    catch {
        Write-Error "Could not import functions"
    }
}

Export-ModuleMember -Function $Public.BaseName