# Automation Guide
## Consult AI-Ge — Scripts & Workflow

**Propósito:** Automatizar todo lo posible sin romper la arquitectura  
**Punto de entrada único:** `.\scripts\run.ps1`

---

## 🚀 SETUP INICIAL (UNA SOLA VEZ)

### 1. Permitir scripts PowerShell
Abre PowerShell **como Administrador** y ejecuta:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Responde `Y` cuando pregunte.

### 2. Verifica que funciona
```powershell
cd C:\Users\boliv\consult-ai-ge
.\scripts\run.ps1 help
```

Deberías ver el menú de comandos.

---

## 📋 COMANDOS DISPONIBLES

### `sync` — Copiar archivos + push
**Cuándo usar:** Cada vez que Claude te da archivos .md nuevos

```powershell
# Básico (copia .md de Downloads y hace push)
.\scripts\run.ps1 sync

# Con info del commit
.\scripts\run.ps1 sync -Week 1 -Day 2 -Task "Auth setup" -Tokens 200
```

**Qué hace:**
1. Busca archivos .md en tu carpeta Downloads
2. Los copia al repo
3. Hace git add + commit + push automáticamente

---

### `daily` — Reporte diario (Developer LLM)
**Cuándo usar:** Al final de cada día de trabajo

```powershell
# Básico
.\scripts\run.ps1 daily -Week 1 -Day 1 -Task "Bubble workspace" -Tokens 150

# Con más detalles
.\scripts\run.ps1 daily `
    -Week 1 -Day 2 `
    -Task "Database schema (8 tables)" `
    -Tokens 200 `
    -Completed "Users table, Consultants table, Clients table" `
    -InProgress "Matches table" `
    -Blockers "None"
```

**Qué hace:**
1. Genera reporte diario en markdown
2. Hace commit con formato: `"Week X, Day Y: [Task] (Model, ~Tokens)"`
3. Push a GitHub
4. Guarda log en `/logs/`

---

### `audit` — Audit semanal (Bolivar, viernes)
**Cuándo usar:** Cada viernes EOD después de leer el weekly report del Developer

```powershell
# Básico
.\scripts\run.ps1 audit -Week 1 -Tokens 1800 -Quality 5

# Con detalles completos
.\scripts\run.ps1 audit `
    -Week 1 `
    -Tokens 1800 `
    -Quality 5 `
    -Escalations 0 `
    -CriticalBugs 0 `
    -TasksDone 5 `
    -TasksTotal 5 `
    -Notes "Sonnet 4.5 manejó todo sin problemas"

# Auto-GO sin confirmación manual
.\scripts\run.ps1 audit -Week 1 -Tokens 1800 -Quality 5 -AutoGO
```

**Qué hace:**
1. Muestra git log de la semana
2. Verifica red flags automáticamente
3. Pide confirmación GO/HOLD
4. Appends entry al AUDIT-LOG.md
5. Commit + push

---

### `new-week` — Generar tareas de próxima semana
**Cuándo usar:** Viernes después del audit GO, para preparar siguiente semana

```powershell
.\scripts\run.ps1 new-week -Week 2   # Para Week 2
.\scripts\run.ps1 new-week -Week 3   # Para Week 3
.\scripts\run.ps1 new-week -Week 4   # Para Week 4
```

**Qué hace:**
1. Genera WEEK-X-TASKS.md con desglose día-a-día
2. Commit + push automáticamente

---

### `status` — Estado del repo
**Cuándo usar:** Para ver resumen rápido en cualquier momento

```powershell
.\scripts\run.ps1 status
```

**Muestra:**
- Proyecto, remote, branch, semana actual, modelo
- Últimos 5 commits

---

## 🗓️ WORKFLOW SEMANAL AUTOMATIZADO

### Lunes (inicio de semana)
```powershell
# 1. Actualiza semana en config.ps1
# (edita: $CURRENT_WEEK = 2, $WEEK_START = "2026-09-26")

# 2. Verifica estado
.\scripts\run.ps1 status
```

### Martes-Jueves (días de trabajo — Developer LLM)
```powershell
# Al final de cada día
.\scripts\run.ps1 daily -Week 1 -Day 2 -Task "Auth setup" -Tokens 200
```

### Viernes EOD (Bolivar)
```powershell
# 1. Audit completo (15 minutos)
.\scripts\run.ps1 audit -Week 1 -Tokens 1800 -Quality 5

# 2. Si GO: generar tasks de próxima semana
.\scripts\run.ps1 new-week -Week 2
```

### Cuando Claude da archivos nuevos (cualquier día)
```powershell
# Descarga los archivos desde Claude
# (se guardan en Downloads automáticamente)

# Luego:
.\scripts\run.ps1 sync
```

---

## ⚙️ GITHUB ACTIONS (Automático)

El archivo `.github/workflows/weekly-audit.yml` corre automáticamente:
- **Cuándo:** Cada viernes 4pm hora Santo Domingo
- **Qué hace:** Genera resumen del git log y lo agrega al AUDIT-LOG.md
- **Lo ves en:** GitHub → tu repo → Actions tab

Esto es **complementario** al audit manual de Bolivar, no lo reemplaza.

---

## 🔧 PERSONALIZACIÓN

### Cambiar semana activa (cada lunes)
Edita `scripts/config.ps1`:
```powershell
$CURRENT_WEEK = 2          # ← Actualizar
$WEEK_START   = "2026-09-26"  # ← Actualizar
$WEEK_END     = "2026-10-03"  # ← Actualizar
```

### Cambiar modelo primary
```powershell
$MODEL_PRIMARY = "Claude Sonnet 4.5"  # o Opus 4.5
```

### Cambiar budget semanal
```powershell
$WEEKLY_TOKEN_BUDGET = 2000   # tokens por semana
```

---

## 🚩 TROUBLESHOOTING

### "execution policy" error
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "git not found"
Instala Git for Windows: https://git-scm.com/download/win

### "nothing to commit"
Normal — significa que no hay cambios nuevos. No es un error.

### Script no encuentra archivos en Downloads
Verifica que los archivos .md estén en:
`C:\Users\boliv\Downloads\` (no subcarpetas)

---

## 📁 ESTRUCTURA DE ARCHIVOS

```
C:\Users\boliv\consult-ai-ge\
├── scripts\
│   ├── config.ps1              ← Editar aquí la config
│   ├── functions.ps1           ← No editar
│   ├── run.ps1                 ← PUNTO DE ENTRADA
│   ├── 01-sync-github.ps1      ← No ejecutar directo
│   ├── 02-weekly-audit.ps1     ← No ejecutar directo
│   ├── 03-daily-report.ps1     ← No ejecutar directo
│   ├── 04-create-week-tasks.ps1← No ejecutar directo
│   └── README.md
├── .github\
│   └── workflows\
│       └── weekly-audit.yml    ← GitHub Actions (auto)
├── logs\                       ← Auto-generado
│   └── *.log                   ← Logs de cada ejecución
└── AUTOMATION-GUIDE.md         ← Este archivo
```

---

**¿Dudas?** Pregunta en el chat. 🚀
