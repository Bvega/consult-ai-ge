# ============================================================
# config.ps1 — Configuración central del proyecto
# Todos los scripts importan este archivo primero.
# NO edites valores en otros scripts; edítalos aquí.
# ============================================================

# --- Rutas ---
$REPO_ROOT   = "C:\Users\boliv\consult-ai-ge"
$SCRIPTS_DIR = "$REPO_ROOT\scripts"
$LOGS_DIR    = "$REPO_ROOT\logs"

# --- Proyecto ---
$PROJECT_NAME  = "Consult AI-Ge"
$GITHUB_REMOTE = "https://github.com/Bvega/consult-ai-ge"
$GITHUB_BRANCH = "main"

# --- Modelos ---
$MODEL_PRIMARY    = "Claude Sonnet 4.5"
$MODEL_ESCALATION = "Claude Opus 4.5"

# --- Presupuesto por semana (tokens) ---
$WEEKLY_TOKEN_BUDGET = 2000
$WEEKLY_TOKEN_WARNING = 1800   # Warning at 90%

# --- Semana actual (actualizar cada lunes) ---
$CURRENT_WEEK = 1
$WEEK_START   = "2026-09-19"
$WEEK_END     = "2026-09-26"

# --- Owner ---
$OWNER_NAME  = "Bolivar"
$OWNER_EMAIL = "bvega@helmsbriscoe.com"   # Actualizar si cambia

# --- Colores para output ---
$COL_OK   = "Green"
$COL_WARN = "Yellow"
$COL_ERR  = "Red"
$COL_INFO = "Cyan"

# --- Función helper para escribir con color ---
function Write-Step  { param($msg) Write-Host "  → $msg" -ForegroundColor $COL_INFO }
function Write-Ok    { param($msg) Write-Host "  ✅ $msg" -ForegroundColor $COL_OK   }
function Write-Warn  { param($msg) Write-Host "  ⚠️  $msg" -ForegroundColor $COL_WARN }
function Write-Err   { param($msg) Write-Host "  ❌ $msg" -ForegroundColor $COL_ERR  }
function Write-Title { param($msg) Write-Host "`n🚀 $msg" -ForegroundColor $COL_INFO  }

# --- Asegurar que logs/ existe ---
if (-not (Test-Path $LOGS_DIR)) { New-Item -ItemType Directory -Path $LOGS_DIR | Out-Null }
