# ============================================================
# run.ps1 — Script maestro: punto de entrada único
# USO: .\scripts\run.ps1 [comando] [opciones]
#
# COMANDOS DISPONIBLES:
#   sync           — Copia .md de Downloads + push
#   daily          — Daily report + commit + push
#   audit          — Weekly audit (viernes)
#   new-week       — Genera WEEK-X-TASKS.md
#   status         — Muestra estado del repo
#   help           — Lista todos los comandos
# ============================================================

param(
    [Parameter(Position=0)]
    [ValidateSet("sync","daily","audit","new-week","status","help")]
    [string]$Command = "help",

    # Compartidos
    [int]   $Week    = 0,
    [int]   $Day     = 0,
    [string]$Task    = "",
    [string]$Model   = "",
    [int]   $Tokens  = 0,

    # Daily-specific
    [string]$Completed  = "",
    [string]$InProgress = "",
    [string]$Blockers   = "None",

    # Audit-specific
    [int]   $Quality     = 5,
    [int]   $Escalations = 0,
    [int]   $CriticalBugs = 0,
    [int]   $TasksDone   = 5,
    [int]   $TasksTotal  = 5,
    [string]$Notes       = "",
    [switch]$AutoGO,

    # Debug
    [switch]$DryRun
)

. "$PSScriptRoot\config.ps1"
. "$PSScriptRoot\functions.ps1"

switch ($Command) {

    "sync" {
        & "$PSScriptRoot\01-sync-github.ps1" `
            -Week $Week -Day $Day -Task $Task `
            -Model $Model -Tokens $Tokens `
            -DryRun:$DryRun
    }

    "daily" {
        if (-not $Week -or -not $Day -or -not $Task) {
            Write-Err "daily requiere: -Week X -Day Y -Task 'descripción'"
            Write-Host ""
            Write-Host "Ejemplo:"
            Write-Host "  .\scripts\run.ps1 daily -Week 1 -Day 1 -Task 'Bubble workspace' -Tokens 150"
            exit 1
        }
        & "$PSScriptRoot\03-daily-report.ps1" `
            -Week $Week -Day $Day -Task $Task `
            -Tokens $Tokens -Model $Model `
            -Completed $Completed -InProgress $InProgress `
            -Blockers $Blockers -DryRun:$DryRun
    }

    "audit" {
        if (-not $Week) {
            Write-Err "audit requiere: -Week X"
            Write-Host ""
            Write-Host "Ejemplo:"
            Write-Host "  .\scripts\run.ps1 audit -Week 1 -Tokens 1800 -Quality 5"
            exit 1
        }
        & "$PSScriptRoot\02-weekly-audit.ps1" `
            -Week $Week -Tokens $Tokens -Quality $Quality `
            -Escalations $Escalations -CriticalBugs $CriticalBugs `
            -TasksDone $TasksDone -TasksTotal $TasksTotal `
            -Notes $Notes -AutoGO:$AutoGO
    }

    "new-week" {
        if (-not $Week) {
            Write-Err "new-week requiere: -Week X (2, 3 o 4)"
            Write-Host ""
            Write-Host "Ejemplo:"
            Write-Host "  .\scripts\run.ps1 new-week -Week 2"
            exit 1
        }
        & "$PSScriptRoot\04-create-week-tasks.ps1" -Week $Week
    }

    "status" {
        Show-RepoSummary
    }

    "help" {
        Write-Host ""
        Write-Host "====================================================" -ForegroundColor $COL_INFO
        Write-Host "  Consult AI-Ge -- Automation Scripts" -ForegroundColor $COL_INFO
        Write-Host "====================================================" -ForegroundColor $COL_INFO
        Write-Host ""
        Write-Host "  COMANDOS:"
        Write-Host ""
        Write-Host "  sync         Copia .md de Downloads + push"
        Write-Host "  daily        Daily report + commit + push"
        Write-Host "  audit        Weekly audit (Viernes EOD)"
        Write-Host "  new-week     Genera WEEK-X-TASKS.md"
        Write-Host "  status       Muestra estado del repo"
        Write-Host "  help         Esta pantalla"
        Write-Host ""
        Write-Host "  EJEMPLOS:"
        Write-Host ""
        Write-Host "  .\scripts\run.ps1 sync"
        Write-Host "  .\scripts\run.ps1 daily -Week 1 -Day 1 -Task 'X' -Tokens 150"
        Write-Host "  .\scripts\run.ps1 audit -Week 1 -Tokens 1800 -Quality 5"
        Write-Host "  .\scripts\run.ps1 new-week -Week 2"
        Write-Host "  .\scripts\run.ps1 status"
        Write-Host ""
        Write-Host "====================================================" -ForegroundColor $COL_INFO
        Write-Host ""
        Write-Host "  Docs: AUTOMATION-GUIDE.md" -ForegroundColor $COL_INFO
        Write-Host ""
    }
}
