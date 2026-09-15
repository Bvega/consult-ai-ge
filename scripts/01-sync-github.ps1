# ============================================================
# 01-sync-github.ps1
# Copia archivos nuevos desde Downloads al repo y hace push.
# USO: .\scripts\01-sync-github.ps1
# USO con semana/dia: .\scripts\01-sync-github.ps1 -Week 1 -Day 2 -Task "Auth setup"
# ============================================================

param(
    [int]   $Week  = $null,
    [int]   $Day   = $null,
    [string]$Task  = "",
    [string]$Model = "",
    [int]   $Tokens = 0,
    [switch]$DryRun             # Simula sin hacer cambios
)

. "$PSScriptRoot\config.ps1"
. "$PSScriptRoot\functions.ps1"

Write-Title "01-SYNC-GITHUB — $PROJECT_NAME"
Assert-Git
Assert-Repo

# --- Copiar archivos .md desde Downloads ---
$downloads = "$env:USERPROFILE\Downloads"
$mdFiles   = Get-ChildItem "$downloads\*.md" -ErrorAction SilentlyContinue

if ($mdFiles) {
    Write-Step "Archivos .md encontrados en Downloads:"
    $mdFiles | ForEach-Object { Write-Host "    $($_.Name)" }

    foreach ($f in $mdFiles) {
        $dest = "$REPO_ROOT\$($f.Name)"
        if ($DryRun) {
            Write-Warn "[DryRun] Copiaría: $($f.Name) → $REPO_ROOT"
        } else {
            Copy-Item $f.FullName $dest -Force
            Write-Ok "Copiado: $($f.Name)"
        }
    }
} else {
    Write-Warn "No hay .md en Downloads — solo sincronizando cambios existentes."
}

# --- Construir mensaje de commit ---
if ($Week -and $Day -and $Task) {
    $mdl = if ($Model) { $Model } else { $MODEL_PRIMARY }
    $tok = if ($Tokens -gt 0) { "~$Tokens tokens" } else { "~? tokens" }
    $commitMsg = "Week $Week, Day $Day`: $Task ($mdl, $tok)"
} else {
    $date      = Get-Date -Format "yyyy-MM-dd HH:mm"
    $commitMsg = "Sync: Auto-update files ($date)"
}

# --- Git sync ---
if ($DryRun) {
    Write-Warn "[DryRun] Commit que haría: $commitMsg"
} else {
    Invoke-GitSync -CommitMsg $commitMsg
}

Write-Title "✅ SYNC COMPLETADO"
Write-Host "  Commit : $commitMsg"
Write-Host "  Remote : $GITHUB_REMOTE"
Write-Host ""
Write-Host "  Verifica en: $GITHUB_REMOTE" -ForegroundColor $COL_INFO
