function prompt {
    $date = Get-Date
    $time = $date.GetDateTimeFormats()[88]
    $curdir = $ExecutionContext.SessionState.Path.CurrentLocation.Path.Split("\")[-1]

    if($curdir.Length -eq 0) {
        $curdir = $ExecutionContext.SessionState.Drive.Current.Name+":\"
    }

    Write-Host "🖥️"$env:COMPUTERNAME" " -BackgroundColor Cyan -ForegroundColor  Red -NoNewline
    Write-Host "📂"$curdir" " -BackgroundColor Yellow -ForegroundColor Black -NoNewline
    Write-Host "⏱️"$time" " -BackgroundColor Magenta -ForegroundColor White
    "🤣👉"
}
