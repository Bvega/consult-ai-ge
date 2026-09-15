# Weekly Audit Checklist
## For Bolivar (Friday EOD Review)

**Purpose:** Verify model usage, token tracking, and quality gates  
**Frequency:** Every Friday, end of day  
**Owner:** Bolivar  
**Duration:** ~15 minutes

---

## 🔍 CHECKLIST

### GIT LOG AUDIT (3 min)
- [ ] Run: `git log --oneline | head -10`
- [ ] ✅ All commits have model info? (e.g., "Week X, Day Y: ... (Sonnet, ~tokens)")
- [ ] ✅ Commits align with weekly plan?
- [ ] ✅ ~5 commits this week?

**If commits missing model info:**
→ Ask Developer LLM to add to future commits

### WEEKLY REPORT AUDIT (5 min)
- [ ] Developer LLM submitted report?
- [ ] Report includes: tokens, model, quality, escalations
- [ ] Tokens <2K this week?
- [ ] Quality ≥ ⭐⭐⭐⭐?
- [ ] Escalations documented?
- [ ] 0 critical bugs?

### QUALITY VERIFICATION (3 min)
- [ ] Tested working features?
- [ ] Any bugs found? (Critical vs minor)
- [ ] Performance OK? (<2s load time)
- [ ] No console errors?

### RED FLAGS CHECK (2 min)
Check for ANY of these:
- [ ] Token burn >25% over budget?
- [ ] Quality <⭐⭐⭐⭐?
- [ ] Escalations >2 this week?
- [ ] Critical bugs >0?
- [ ] Tasks incomplete?
- [ ] No weekly report submitted?

**If ANY red flag detected:**
→ HOLD decision & discuss with Developer

### AUDIT-LOG UPDATE (2 min)
- [ ] Add Week X entry to AUDIT-LOG.md
- [ ] Include: tokens, model, quality, decision
- [ ] Commit to GitHub

### GO/HOLD DECISION (1 min)
**ALL of these must be ✅ for GO:**
- ✅ Tokens <budget
- ✅ Quality ≥⭐⭐⭐⭐
- ✅ 0 critical bugs
- ✅ All tasks completed
- ✅ No red flags

**If ANY ❌:**
→ HOLD & discuss

---

## 📝 AUDIT-LOG ENTRY

Copy-paste this each Friday and fill in:

```markdown
## Week X Review (Date: YYYY-MM-DD)

### Model Usage
- Primary Model: Claude Sonnet 4.5
- Escalations: [X] (to Opus)
- Tokens spent: ~XK

### Quality
- Rating: ⭐⭐⭐⭐⭐ (5/5)
- Bugs found: [N] critical, [N] minor
- Tasks completed: Y/Z

### Success Criteria
- [x] Tokens <budget (actual XK, budget 2K)
- [x] Quality ≥⭐⭐⭐⭐
- [x] 0 critical bugs
- [x] All tasks completed
- [x] No red flags

### Escalations
[If none: None]
[If escalations: List with reason]

### Notes
[Observations, kudos, concerns]

### DECISION
✅ **GO to Week X+1**
```

---

## 🚩 RED FLAGS REFERENCE

### Token Burn >25% Over Budget
**Threshold:** If spent >2.5K in a 2K week
**Action:** Discuss with Developer LLM
**Cause:** Over-scoping or inefficiency
**Fix:** Reduce scope next week or optimize

### Quality <⭐⭐⭐⭐
**Threshold:** Rating drops below 4 stars
**Action:** HOLD & discuss
**Cause:** Bugs, performance, incomplete features
**Fix:** Dev does rework before proceeding

### Escalations >2
**Threshold:** More than 2 escalations to Opus
**Action:** Discuss model strategy
**Cause:** Sonnet insufficient or over-complex tasks
**Fix:** Re-scope tasks or plan more Opus use

### Critical Bugs >0
**Threshold:** Any bug that breaks happy path
**Action:** Must fix before proceeding
**Cause:** Insufficient testing
**Fix:** Dev tests more thoroughly

### Tasks Incomplete
**Threshold:** <5 of 5 tasks done
**Action:** Extend deadline or reduce scope
**Cause:** Underestimated effort or blockers
**Fix:** Extend to next week or split task

---

## ⏰ TIMING

**Every Friday:**
- 4:00 PM - Developer LLM submits report
- 4:15 PM - Bolivar reads report
- 4:30 PM - Run this checklist
- 4:45 PM - Update AUDIT-LOG.md
- 5:00 PM - Communicate GO/HOLD decision

---

**Document Version:** 1.0  
**Status:** READY FOR WEEKLY USE
