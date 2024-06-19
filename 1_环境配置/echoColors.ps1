$colors = [System.Enum]::GetValues([System.ConsoleColor])
foreach ($bg in $colors) {
    foreach ($fg in $colors) {
        Write-Host "$bg on $fg" -BackgroundColor $bg -ForegroundColor $fg
    }
}
