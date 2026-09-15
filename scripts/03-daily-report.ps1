# ============================================================
# 03-daily-report.ps1
# Genera reporte diario, hace commit con modelo info y push.
# USO: .\scripts\03-daily-report.ps1 -Week 1 -Day 1 -Task "Bubble workspace" -Tokens 150
# ============================================================

param(
    [Parameter(Mandatory)][int]   $Week,
    [Parameter(Mandatory)][int]   $Day,
    [Parameter(Mandatory)][string]$Task,
    [int]   $Tokens     = 150,
    [string]$Model      = "",
    [string]$Completed  = "",       # Comma-separated: "Task A,Task B"
    [string]$InProgress = "",
    [string]$Blockers   = "None",
    [switch]$DryRun
)

. "$PSScriptRoot\config.ps1"
. "$PSScriptRoot\functions.ps1"

$mdl  = if ($Model) { $Model } else { $MODEL_PRIMARY }
$date = Get-Date -Format "yyyy-MM-dd"
$time = Get-Date -Format "HH:mm"

Write-Title "03-DAILY-REPORT — Week $Week Day $Day"
Assert-Git
Assert-Repo

# --- Formatear listas ---
$completedList  = if ($Completed)  { ($Completed  -split ",") | ForEach-Object { "- ✅ $($_.Trim())" } | Out-String } else { "- ✅ $Task" }
$inProgressList = if ($InProgress) { ($InProgress -split ",") | ForEach-Object { "- 🔄 $($_.Trim())" } | Out-String } else { "- (none)" }
$blockersList   = "- $Blockers"

# --- Generar reporte en markdown ---
$report = @"
## Day $Day Report — Week $Week ($date $time)

### ✅ Completed
$completedList
### 🔄 In Progress
$inProgressList
### 🚧 Blockers
$blockersList

### 📊 Metrics
- Tokens spent : ~$Tokens
- Model used   : $mdl
- Budget left  : ~$($WEEKLY_TOKEN_BUDGET - $Tokens) tokens remaining this week

### Ready for Day $($Day+1)?
✅ YES
"@

# --- Mostrar reporte ---
Write-Host ""
Write-Host $report -ForegroundColor $COL_INFO
Write-Host ""

# --- Guardar log ---
if (-not $DryRun) {
    New-LogEntry -ScriptName "daily-w${Week}d${Day}" -Content $report | Out-Null
}

# --- Commit con formato estándar ---
$commitMsg = "Week $Week, Day ${Day}: $Task ($mdl, ~$Tokens tokens)"

if ($DryRun) {
    Write-Warn "[DryRun] Commit: $commitMsg"
} else {
    Invoke-GitSync -CommitMsg $commitMsg
}

# --- RESUMEN ---
Write-Title "✅ DAY $Day REPORT DONE"
Write-Host "  Commit : $commitMsg"
Write-Host "  Tokens : ~$Tokens / $WEEKLY_TOKEN_BUDGET weekly"
Write-Host "  Log    : logs\daily-w${Week}d${Day}_*.log"
Write-Host ""
Write-Host "  Mañana: Week $Week, Day $($Day+1)" -ForegroundColor $COL_INFO
