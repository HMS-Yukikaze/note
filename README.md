# note  
个人开发笔记  
[Windows](https://github.com/HMS-Yukikaze/note/tree/windows)   
[linux](https://github.com/HMS-Yukikaze/note/tree/linux)    
[macOS](https://github.com/HMS-Yukikaze/note/tree/macos)
[cppLearn](https://github.com/HMS-Yukikaze/note/tree/cppLearn)  
[designMode](https://github.com/HMS-Yukikaze/note/tree/designMode)
[Boost](https://github.com/HMS-Yukikaze/note/tree/Boost)

抽象powershell
function prompt {
    $date = Get-Date
    $time = $date.GetDateTimeFormats()[88]
    $curdir = $ExecutionContext.SessionState.Path.CurrentLocation.Path.Split("\")[-1]

    if($curdir.Length -eq 0) {
        $curdir = $ExecutionContext.SessionState.Drive.Current.Name+":\"
    }

    Write-Host ""$env:USERNAME"@"$env:COMPUTERNAME" " -BackgroundColor Cyan -ForegroundColor Black -NoNewline
    Write-Host " DIR:"$curdir" " -BackgroundColor Yellow -ForegroundColor Black -NoNewline
    Write-Host ""$time" " -BackgroundColor Magenta -ForegroundColor White
    "🤣👉"
}
