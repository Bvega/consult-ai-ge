# ============================================================
# functions.ps1 — Funciones reutilizables
# Requiere: . .\scripts\config.ps1
# ============================================================

# --- Verificar que estamos en el repo correcto ---
function Assert-Repo {
    if (-not (Test-Path "$REPO_ROOT\.git")) {
        Write-Err "No se encontró .git en $REPO_ROOT"
        Write-Err "Ejecuta este script desde C:\Users\boliv\consult-ai-ge"
        exit 1
    }
    Set-Location $REPO_ROOT
    Write-Ok "Repo verificado: $REPO_ROOT"
}

# --- Git: status limpio? ---
function Get-GitStatus {
    $status = git status --porcelain
    if ($status) {
        return $false   # hay cambios sin commitear
    }
    return $true
}

# --- Git: add + commit + push con mensaje estándar ---
function Invoke-GitSync {
    param(
        [string]$CommitMsg,
        [switch]$PushToRemote = $true
    )
    Write-Step "git add ."
    git add . | Out-Null

    $dirty = git status --porcelain
    if (-not $dirty) {
        Write-Warn "Nothing to commit — working tree clean"
        return
    }

    Write-Step "git commit: $CommitMsg"
    git commit -m $CommitMsg | Out-Null

    if ($PushToRemote) {
        Write-Step "git push origin $GITHUB_BRANCH"
        git push origin $GITHUB_BRANCH
        Write-Ok "Push exitoso → $GITHUB_REMOTE"
    }
}

# --- Crear archivo de log con timestamp ---
function New-LogEntry {
    param(
        [string]$ScriptName,
        [string]$Content
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
    $logFile   = "$LOGS_DIR\${ScriptName}_${timestamp}.log"
    $Content | Out-File -FilePath $logFile -Encoding utf8
    Write-Ok "Log guardado: $logFile"
    return $logFile
}

# --- Leer última línea del AUDIT-LOG.md ---
function Get-LastAuditEntry {
    $auditFile = "$REPO_ROOT\AUDIT-LOG.md"
    if (-not (Test-Path $auditFile)) {
        Write-Warn "AUDIT-LOG.md no encontrado"
        return $null
    }
    return (Get-Content $auditFile -Raw)
}

# --- Append bloque de texto a un .md ---
function Add-ToMarkdown {
    param(
        [string]$FilePath,
        [string]$Content
    )
    if (-not (Test-Path $FilePath)) {
        Write-Err "Archivo no encontrado: $FilePath"
        return
    }
    "`n$Content" | Add-Content -Path $FilePath -Encoding utf8
    Write-Ok "Agregado a: $(Split-Path $FilePath -Leaf)"
}

# --- Verificar git instalado ---
function Assert-Git {
    try {
        git --version | Out-Null
        Write-Ok "Git disponible"
    } catch {
        Write-Err "Git no encontrado. Instala Git for Windows."
        exit 1
    }
}

# --- Mostrar resumen del repo ---
function Show-RepoSummary {
    Write-Title "REPO SUMMARY"
    Write-Host "  Proyecto : $PROJECT_NAME"
    Write-Host "  Remote   : $GITHUB_REMOTE"
    Write-Host "  Branch   : $GITHUB_BRANCH"
    Write-Host "  Semana   : $CURRENT_WEEK"
    Write-Host "  Modelo   : $MODEL_PRIMARY"
    Write-Host ""
    Write-Host "  Últimos commits:" -ForegroundColor $COL_INFO
    git log --oneline -5 | ForEach-Object { Write-Host "    $_" }
    Write-Host ""
}

# --- Pedir confirmación Y/N ---
function Confirm-Action {
    param([string]$Prompt)
    $resp = Read-Host "$Prompt [Y/N]"
    return ($resp -eq "Y" -or $resp -eq "y")
}
