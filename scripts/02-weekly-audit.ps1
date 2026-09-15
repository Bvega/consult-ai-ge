# ============================================================
# 02-weekly-audit.ps1
# Audit de viernes: revisa git log, tokens, calidad y genera
# entry para AUDIT-LOG.md. Bolivar solo revisa y aprueba.
# USO: .\scripts\02-weekly-audit.ps1 -Week 1 -Tokens 1800 -Quality 5
# ============================================================

param(
    [int]   $Week    = $CURRENT_WEEK,
    [int]   $Tokens  = 0,
    [int]   $Quality = 5,           # 1-5 estrellas
    [int]   $Escalations = 0,
    [int]   $CriticalBugs = 0,
    [int]   $TasksDone = 5,
    [int]   $TasksTotal = 5,
    [string]$Notes   = "",
    [switch]$AutoGO                 # Skip confirmación, GO automático
)

. "$PSScriptRoot\config.ps1"
. "$PSScriptRoot\functions.ps1"

$date      = Get-Date -Format "yyyy-MM-dd"
$stars     = "⭐" * $Quality
$weekBudget = $WEEKLY_TOKEN_BUDGET

Write-Title "02-WEEKLY-AUDIT — Week $Week — $date"
Assert-Git
Assert-Repo

# --- PASO 1: Git log de la semana ---
Write-Step "Revisando git log de la semana..."
Write-Host ""
git log --oneline --since="7 days ago" | ForEach-Object { Write-Host "    $_" }
Write-Host ""

# --- PASO 2: Verificar commits tienen modelo info ---
$commits     = git log --oneline --since="7 days ago"
$withModel   = ($commits | Select-String "Sonnet|Opus|Claude").Count
$totalCommits = ($commits | Measure-Object -Line).Lines

Write-Step "Commits esta semana: $totalCommits (con modelo: $withModel)"

if ($withModel -lt $totalCommits) {
    Write-Warn "Algunos commits no tienen info de modelo. Recuérdale al Developer."
}

# --- PASO 3: Red flags check ---
Write-Step "Verificando red flags..."

$redFlags = @()

if ($Tokens -gt ($weekBudget * 1.25)) {
    $redFlags += "❌ Tokens ($Tokens) supera 125% del budget ($weekBudget)"
}
if ($Quality -lt 4) {
    $redFlags += "❌ Calidad ($stars) bajo ⭐⭐⭐⭐"
}
if ($Escalations -gt 2) {
    $redFlags += "❌ Escalaciones ($Escalations) supera límite (2)"
}
if ($CriticalBugs -gt 0) {
    $redFlags += "❌ Critical bugs: $CriticalBugs encontrados"
}
if ($TasksDone -lt $TasksTotal) {
    $redFlags += "⚠️  Tasks: $TasksDone/$TasksTotal completadas"
}

if ($redFlags.Count -eq 0) {
    Write-Ok "Sin red flags detectadas"
} else {
    foreach ($flag in $redFlags) { Write-Warn $flag }
}

# --- PASO 4: Decisión GO/HOLD ---
$decision = ""
if ($redFlags.Count -eq 0) {
    if ($AutoGO) {
        $decision = "GO"
    } else {
        $go = Confirm-Action "¿Apruebas GO a Week $($Week+1)?"
        $decision = if ($go) { "GO" } else { "HOLD" }
    }
} else {
    Write-Warn "Red flags detectadas — HOLD recomendado"
    $go = Confirm-Action "¿Quieres hacer GO de todas formas?"
    $decision = if ($go) { "GO (override)" } else { "HOLD" }
}

$decisionIcon = if ($decision -like "GO*") { "✅" } else { "❌" }

# --- PASO 5: Generar entry para AUDIT-LOG.md ---
$tokenStatus = if ($Tokens -le $weekBudget) { "✅ On budget" } else { "⚠️ Over budget" }
$notesBlock  = if ($Notes) { $Notes } else { "Ninguna." }

$auditEntry = @"

---

## Week $Week Review ($date)

### Model Usage
- Primary Model : $MODEL_PRIMARY
- Escalations   : $Escalations
- Tokens spent  : ~${Tokens} ($tokenStatus — budget: $weekBudget)

### Quality
- Rating        : $stars ($Quality/5)
- Critical bugs : $CriticalBugs
- Tasks done    : $TasksDone/$TasksTotal

### Red Flags
$(if ($redFlags.Count -eq 0) { "Ninguna." } else { $redFlags -join "`n" })

### Notes
$notesBlock

### Decision
$decisionIcon **$decision to Week $($Week+1)**
"@

# --- PASO 6: Append al AUDIT-LOG.md ---
Add-ToMarkdown -FilePath "$REPO_ROOT\AUDIT-LOG.md" -Content $auditEntry

# --- PASO 7: Log file ---
New-LogEntry -ScriptName "weekly-audit-week$Week" -Content $auditEntry | Out-Null

# --- PASO 8: Git sync ---
$commitMsg = "Week $Week Audit: $decision — $stars — ${Tokens}t ($MODEL_PRIMARY)"
Invoke-GitSync -CommitMsg $commitMsg

# --- RESUMEN FINAL ---
Write-Title "AUDIT COMPLETADO"
Write-Host "  Semana       : $Week"
Write-Host "  Decisión     : $decisionIcon $decision"
Write-Host "  Tokens       : ~$Tokens / $weekBudget"
Write-Host "  Calidad      : $stars"
Write-Host "  Red flags    : $($redFlags.Count)"
Write-Host "  Tasks        : $TasksDone/$TasksTotal"
Write-Host ""

if ($decision -like "GO*") {
    Write-Ok "Listo para Week $($Week+1). ¡Buen trabajo! 🚀"
} else {
    Write-Warn "HOLD activo. Discute con Developer LLM antes de continuar."
}
