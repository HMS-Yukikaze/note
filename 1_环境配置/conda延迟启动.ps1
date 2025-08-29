# ===============================
# PowerShell profile.ps1
# ===============================

# 一些你自己常用的配置，可以写在这里
# 例如提示符设置、别名、环境变量等
# 示例：设置一个好看的提示符
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

# ===============================
# Conda 延迟加载
# ===============================

# conda 安装路径（修改为你自己的）
$condaPath = "D:\ProgramData\miniconda3\Scripts\conda.exe"

function miniconda {
    if (Test-Path $condaPath) {
        # 初始化 conda
        (& $condaPath "shell.powershell" "hook") | Out-String | Where-Object {$_} | Invoke-Expression

        # 移除这个函数，避免重复初始化
        Remove-Item function:\miniconda -Force

        # 如果想在输入 miniconda 之后自动进入 base 环境，可以加上：
        conda activate base
    }
    else {
        Write-Error "conda not found at $condaPath"
    }
}

# ===============================
# （可选）替换 conda 命令为延迟加载
# ===============================

# 让输入 conda 也能触发初始化，而不是输入 miniconda
function conda {
    miniconda
    conda @args   # 把原本的参数传递给 conda
}
