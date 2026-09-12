# GitHub Setup Instructions

## Step 1: Clone
git clone https://github.com/Bvega/consult-ai-ge
cd consult-ai-ge

## Step 2: Add Files
git add .

## Step 3: Commit
git commit -m "Initial commit: Phase 1-4 documentation complete"

## Step 4: Push
git push origin main

## Step 5: Verify
Open: https://github.com/Bvega/consult-ai-ge

## GitHub Workflow During Build

### Daily (Developer LLM)
git pull origin main
[make changes]
git add .
git commit -m "Week X, Day Y: [description] (Model, ~Tokens)"
git push origin main

### Weekly (Bolivar)
git log --oneline
[review progress]
[update AUDIT-LOG.md]
[decide GO / HOLD]

**Setup Date:** 2026-09-12
**Status:** Ready for Build Phase
