# ============================================================
# SETUP.ps1 - Setup inicial COMPLETO (ejecutar una sola vez)
#
# USO:
#   Set-ExecutionPolicy Bypass -Scope Process -Force; .\SETUP.ps1
# ============================================================

$REPO_ROOT   = "C:\Users\boliv\consult-ai-ge"
$DOWNLOADS   = "$env:USERPROFILE\Downloads"
$ZIP_NAME    = "consult-ai-ge-automazion.zip"
$ZIP_PATH    = "$DOWNLOADS\$ZIP_NAME"
$EXTRACT_DIR = "$DOWNLOADS\consult-ai-ge-automazion"

function Write-Title { param($msg) Write-Host "`n[>>] $msg" -ForegroundColor Cyan  }
function Write-Ok    { param($msg) Write-Host "  [OK]  $msg" -ForegroundColor Green }
function Write-Step  { param($msg) Write-Host "  -->  $msg" -ForegroundColor Cyan   }
function Write-Warn  { param($msg) Write-Host "  [!!] $msg" -ForegroundColor Yellow }
function Write-Err   { param($msg) Write-Host "  [XX] $msg" -ForegroundColor Red    }

Clear-Host
Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  Consult AI-Ge -- SETUP INICIAL (una sola vez)   " -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------------------
# PASO 1: Execution Policy
# ------------------------------------------------------------
Write-Title "PASO 1/5 - Execution Policy"
$policy = Get-ExecutionPolicy -Scope CurrentUser
if ($policy -eq "RemoteSigned" -or $policy -eq "Unrestricted") {
    Write-Ok "ExecutionPolicy ya configurada ($policy)"
} else {
    try {
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Write-Ok "ExecutionPolicy -> RemoteSigned"
    } catch {
        Set-ExecutionPolicy RemoteSigned -Scope Process -Force
        Write-Ok "ExecutionPolicy -> RemoteSigned (Process)"
    }
}

# ------------------------------------------------------------
# PASO 2: Verificar Git
# ------------------------------------------------------------
Write-Title "PASO 2/5 - Verificar Git"
try {
    $gitVersion = git --version
    Write-Ok "Git: $gitVersion"
} catch {
    Write-Err "Git no encontrado. Instala: https://git-scm.com/download/win"
    exit 1
}

# ------------------------------------------------------------
# PASO 3: Extraer ZIP
# ------------------------------------------------------------
Write-Title "PASO 3/5 - Extraer ZIP desde Downloads"

if (-not (Test-Path $ZIP_PATH)) {
    Write-Err "No encontrado: $ZIP_PATH"
    Write-Warn "Asegurate de que el archivo se llama exactamente: $ZIP_NAME"
    exit 1
}

Write-Step "Extrayendo $ZIP_NAME..."
if (Test-Path $EXTRACT_DIR) {
    Remove-Item $EXTRACT_DIR -Recurse -Force
}
Expand-Archive -Path $ZIP_PATH -DestinationPath $EXTRACT_DIR -Force
Write-Ok "Extraido en: $EXTRACT_DIR"

# Mostrar contenido extraido
$extracted = Get-ChildItem $EXTRACT_DIR -Recurse -File
Write-Step "Archivos encontrados en ZIP: $($extracted.Count)"
$extracted | ForEach-Object { Write-Host "      $($_.Name)" }

# ------------------------------------------------------------
# PASO 4: Copiar archivos al repo
# ------------------------------------------------------------
Write-Title "PASO 4/5 - Copiar archivos al repo"

# Crear directorios
$dirs = @("$REPO_ROOT\scripts", "$REPO_ROOT\.github\workflows", "$REPO_ROOT\logs")
foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Ok "Creado: $(Split-Path $dir -Leaf)"
    }
}

# Mapa: nombre de archivo -> destino en repo
$filemap = @{
    "config.ps1"                  = "scripts\config.ps1"
    "functions.ps1"               = "scripts\functions.ps1"
    "run.ps1"                     = "scripts\run.ps1"
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

$ok = 0; $missing = @()

foreach ($fname in $filemap.Keys) {
    # Buscar el archivo en cualquier subdirectorio del ZIP
    $found = Get-ChildItem $EXTRACT_DIR -Recurse -Filter $fname | Select-Object -First 1
    if ($found) {
        $dest = "$REPO_ROOT\$($filemap[$fname])"
        Copy-Item $found.FullName $dest -Force
        Write-Ok "Copiado: $fname"
        $ok++
    } else {
        $missing += $fname
    }
}

Write-Host ""
Write-Ok "Copiados: $ok / $($filemap.Count)"
if ($missing.Count -gt 0) {
    Write-Warn "No encontrados en ZIP ($($missing.Count)):"
    $missing | ForEach-Object { Write-Host "    - $_" -ForegroundColor Yellow }
}

# ------------------------------------------------------------
# PASO 5: Git push
# ------------------------------------------------------------
Write-Title "PASO 5/5 - Git push"
Set-Location $REPO_ROOT
$dirty = git status --porcelain
if ($dirty) {
    git add .
    $date = Get-Date -Format "yyyy-MM-dd HH:mm"
    git commit -m "Setup: Install automation system from ZIP ($date)"
    git push origin main
    Write-Ok "Push exitoso"
} else {
    Write-Ok "Nada nuevo que commitear"
}

# ------------------------------------------------------------
# RESUMEN
# ------------------------------------------------------------
Write-Host ""
Write-Host "====================================================" -ForegroundColor Green
Write-Host "  [OK] SETUP COMPLETADO" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  De ahora en adelante un solo comando:"
Write-Host ""
Write-Host "  .\scripts\run.ps1 help    -> ver todos los comandos" -ForegroundColor Cyan
Write-Host "  .\scripts\run.ps1 sync    -> copiar .md + push"      -ForegroundColor Cyan
Write-Host "  .\scripts\run.ps1 status  -> estado del repo"        -ForegroundColor Cyan
Write-Host ""
Write-Host "====================================================" -ForegroundColor Green
Write-Host ""
