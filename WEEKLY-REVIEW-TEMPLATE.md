# Weekly Review Template
## Friday EOD Gate Decision

**For:** Bolivar (Project Owner)  
**When:** Every Friday, end of day  
**Duration:** 20-30 minutes  
**Output:** GO/HOLD decision + AUDIT-LOG update

---

## 📋 STEP 1: REVIEW GIT LOG (5 min)

```bash
git log --oneline | head -10
```

**Check:**
- ✅ 5+ commits this week?
- ✅ All commits have model info? (e.g., "Week X, Day Y: ... (Sonnet, ~200 tokens)")
- ✅ Progress aligns with weekly plan?

**Example Good:**
```
abc1234 Week 1, Day 5: Profile creation (Sonnet, ~300 tokens)
def5678 Week 1, Day 4: Email setup (Sonnet, ~200 tokens)
ghi9012 Week 1, Day 3: Auth workflows (Sonnet, ~300 tokens)
```

---

## 📊 STEP 2: READ WEEKLY REPORT (10 min)

**Developer LLM should submit Friday EOD:**

```markdown
## Week X Model Report (Date: YYYY-MM-DD)

### Summary
- Days completed: X/5
- Models used: Sonnet 4.5
- Escalations: 0
- Critical bugs: 0

### Day-by-Day
- Day 1: [Task] ✅ (Sonnet, ~200 tokens)
- Day 2: [Task] ✅ (Sonnet, ~250 tokens)

### Escalations
[If any]

### Notes
[Any concerns or blockers]

### Ready for Week X+1?
✅ GO / ❌ HOLD
```

**Check:**
- ✅ Tokens < weekly budget? (target: <2K/week)
- ✅ Quality ≥ ⭐⭐⭐⭐?
- ✅ Tasks completed as planned?
- ✅ No red flags?
- ✅ Escalations documented?

---

## 🔍 STEP 3: VERIFY QUALITY

**Ask yourself:**
- [ ] Is the output working correctly?
- [ ] Did it pass the stage gate criteria?
- [ ] Are there bugs? (Critical? Minor?)
- [ ] Is the code quality good? (For Bubble: workflows clean, no errors)

**Rating Scale:**
- ⭐⭐⭐⭐⭐ (5) = Excellent, no issues
- ⭐⭐⭐⭐ (4) = Good, 1-2 minor issues
- ⭐⭐⭐ (3) = Acceptable, needs review
- ⭐⭐ (2) = Problematic, needs rework
- ⭐ (1) = Broken, cannot proceed

**Target:** Always ≥ ⭐⭐⭐⭐

---

## 📊 STEP 4: UPDATE AUDIT-LOG.md

Add this section to AUDIT-LOG.md:

```markdown
## Week X Review (Date: YYYY-MM-DD)

### Summary
- Model used: Claude Sonnet 4.5
- Tokens spent: [X]K
- Quality: ⭐⭐⭐⭐⭐
- Tasks completed: Y/Z
- Bugs found: 0 critical

### Escalations
[If any]

### Decision
✅ GO to Week X+1

### Notes
[Any observations]
```

---

## 🚩 STEP 5: RED FLAGS CHECK

**If ANY of these exist, escalate immediately:**

- [ ] Token burn >25% over budget
- [ ] Quality <⭐⭐⭐⭐
- [ ] Escalations >2 this week
- [ ] Critical bugs >0
- [ ] Tasks not completed at EOD
- [ ] Developer LLM didn't submit report

**If red flag detected:**
- Don't say "GO"
- Say "HOLD & discuss with Developer"
- Understand what went wrong
- Decide on fixes before next week

---

## ✅ STEP 6: MAKE GO/HOLD DECISION

### GO CRITERIA:
- ✅ Tokens < budget
- ✅ Quality ≥ ⭐⭐⭐⭐
- ✅ No critical bugs
- ✅ All tasks completed
- ✅ 0 red flags

### HOLD CRITERIA:
- ❌ Any GO criteria not met
- ❌ Need to discuss with Developer LLM
- ❌ Need to adjust strategy for next week

---

## 💬 STEP 7: COMMUNICATE DECISION

**Comment on GitHub (optional but good practice):**

```markdown
## Week X Review - GATE DECISION

✅ GO to Week X+1

**Summary:**
- Tokens spent: XK (on budget)
- Quality: ⭐⭐⭐⭐⭐
- Tasks: Y/Z completed
- Bugs: 0 critical

**Excellent work. Ready for next week.**
```

---

## ⏰ TIMING

**Friday Schedule:**
- 4:00 PM: Developer LLM submits weekly report
- 4:15 PM: Bolivar reads report + reviews git log
- 4:30 PM: Bolivar checks quality + red flags
- 4:45 PM: Bolivar updates AUDIT-LOG.md
- 5:00 PM: Bolivar makes GO/HOLD decision

**Total:** ~15 minutes Bolivar time each Friday

---

**Document Version:** 1.0  
**Status:** READY FOR WEEKLY USE
