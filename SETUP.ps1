# ============================================================
# SETUP.ps1 - Setup inicial COMPLETO (ejecutar una sola vez)
#
# USO:
#   Set-ExecutionPolicy Bypass -Scope Process -Force; .\SETUP.ps1
# ============================================================

$REPO_ROOT   = "C:\Users\boliv\consult-ai-ge"
$DOWNLOADS   = "$env:USERPROFILE\Downloads"
$GITHUB_REPO = "https://github.com/Bvega/consult-ai-ge.git"

function Write-Title { param($msg) Write-Host "`n[>>] $msg" -ForegroundColor Cyan   }
function Write-Ok    { param($msg) Write-Host "  [OK]  $msg" -ForegroundColor Green  }
function Write-Step  { param($msg) Write-Host "  -->  $msg" -ForegroundColor Cyan    }
function Write-Warn  { param($msg) Write-Host "  [!!] $msg" -ForegroundColor Yellow  }
function Write-Err   { param($msg) Write-Host "  [XX] $msg" -ForegroundColor Red     }

Clear-Host
Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  Consult AI-Ge -- SETUP INICIAL (una sola vez)   " -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------------------
# PASO 1: Execution Policy
# ------------------------------------------------------------
Write-Title "PASO 1/4 - Execution Policy"

$policy = Get-ExecutionPolicy -Scope CurrentUser
if ($policy -eq "RemoteSigned" -or $policy -eq "Unrestricted") {
    Write-Ok "ExecutionPolicy ya configurada ($policy)"
} else {
    Write-Step "Configurando RemoteSigned para CurrentUser..."
    try {
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Write-Ok "ExecutionPolicy -> RemoteSigned"
    } catch {
        Write-Warn "No se pudo configurar CurrentUser. Usando Process scope..."
        Set-ExecutionPolicy RemoteSigned -Scope Process -Force
        Write-Ok "ExecutionPolicy -> RemoteSigned (Process scope)"
    }
}

# ------------------------------------------------------------
# PASO 2: Verificar Git
# ------------------------------------------------------------
Write-Title "PASO 2/4 - Verificar Git"

try {
    $gitVersion = git --version
    Write-Ok "Git encontrado: $gitVersion"
} catch {
    Write-Err "Git no encontrado."
    Write-Host ""
    Write-Host "  Instala Git for Windows:" -ForegroundColor Yellow
    Write-Host "  https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Despues de instalar, cierra y reabre PowerShell y corre este script de nuevo."
    exit 1
}

# ------------------------------------------------------------
# PASO 3: Copiar archivos desde Downloads al repo
# ------------------------------------------------------------
Write-Title "PASO 3/4 - Copiar archivos al repo"

if (-not (Test-Path $REPO_ROOT)) {
    Write-Err "Repo no encontrado en $REPO_ROOT"
    Write-Warn "Clonalo primero:"
    Write-Host "  git clone $GITHUB_REPO $REPO_ROOT"
    exit 1
}

Set-Location $REPO_ROOT

# Crear directorios necesarios
$dirs = @(
    "$REPO_ROOT\scripts",
    "$REPO_ROOT\.github\workflows",
    "$REPO_ROOT\logs"
)
foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Ok "Directorio creado: $(Split-Path $dir -Leaf)"
    } else {
        Write-Ok "Directorio existe: $(Split-Path $dir -Leaf)"
    }
}

# Mapa: nombre en Downloads -> destino en repo
$filesToCopy = @{
    "run.ps1"                     = "scripts\run.ps1"
    "config.ps1"                  = "scripts\config.ps1"
    "functions.ps1"               = "scripts\functions.ps1"
    "01-sync-github.ps1"          = "scripts\01-sync-github.ps1"
    "02-weekly-audit.ps1"         = "scripts\02-weekly-audit.ps1"
    "03-daily-report.ps1"         = "scripts\03-daily-report.ps1"
    "04-create-week-tasks.ps1"    = "scripts\04-create-week-tasks.ps1"
    "WEEK-1-TASKS.md"             = "WEEK-1-TASKS.md"
    "BUBBLE-SETUP-CHECKLIST.md"   = "BUBBLE-SETUP-CHECKLIST.md"
    "WEEKLY-REVIEW-TEMPLATE.md"   = "WEEKLY-REVIEW-TEMPLATE.md"
    "DEV-LLM-QUICKSTART-FINAL.md" = "DEV-LLM-QUICKSTART-FINAL.md"
    "DAILY-WORKFLOW.md"           = "DAILY-WORKFLOW.md"
    "AUDIT-CHECKLIST-WEEKLY.md"   = "AUDIT-CHECKLIST-WEEKLY.md"
    "RED-FLAGS-ESCALATION.md"     = "RED-FLAGS-ESCALATION.md"
    "AUTOMATION-GUIDE.md"         = "AUTOMATION-GUIDE.md"
    "weekly-audit.yml"            = ".github\workflows\weekly-audit.yml"
}

$copied  = 0
$missing = @()

foreach ($src in $filesToCopy.Keys) {
    $srcPath  = "$DOWNLOADS\$src"
    $destPath = "$REPO_ROOT\$($filesToCopy[$src])"
    if (Test-Path $srcPath) {
        Copy-Item $srcPath $destPath -Force
        Write-Ok "Copiado: $src"
        $copied++
    } else {
        $missing += $src
    }
}

Write-Host ""
Write-Ok "Copiados: $copied / $($filesToCopy.Count)"

if ($missing.Count -gt 0) {
    Write-Host ""
    Write-Warn "Faltaron $($missing.Count) archivos en Downloads:"
    $missing | ForEach-Object { Write-Host "    - $_" -ForegroundColor Yellow }
    Write-Host ""
    Write-Warn "Descargalos desde Claude y corre: .\SETUP.ps1"
}

# ------------------------------------------------------------
# PASO 4: Git add + commit + push
# ------------------------------------------------------------
Write-Title "PASO 4/4 - Git push"

$dirty = git status --porcelain
if ($dirty) {
    git add .
    $date = Get-Date -Format "yyyy-MM-dd HH:mm"
    git commit -m "Setup: Add automation system + all Week 1 files ($date)"
    git push origin main
    Write-Ok "Push exitoso -> $GITHUB_REPO"
} else {
    Write-Ok "Nada que commitear - repo ya actualizado"
}

# ------------------------------------------------------------
# RESUMEN
# ------------------------------------------------------------
Write-Host ""
Write-Host "====================================================" -ForegroundColor Green
Write-Host "  [OK] SETUP COMPLETADO" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Punto de entrada unico de ahora en adelante:"
Write-Host ""
Write-Host "  .\scripts\run.ps1 help      -> ver comandos"    -ForegroundColor Cyan
Write-Host "  .\scripts\run.ps1 sync      -> copiar .md + push" -ForegroundColor Cyan
Write-Host "  .\scripts\run.ps1 status    -> estado del repo"  -ForegroundColor Cyan
Write-Host ""
Write-Host "  Docs: AUTOMATION-GUIDE.md"
Write-Host "  Repo: https://github.com/Bvega/consult-ai-ge"
Write-Host "====================================================" -ForegroundColor Green
Write-Host ""
