# Red Flags & Escalation Procedure
## When to Escalate (Developer LLM)

---

## 🚩 RED FLAGS - Developer LLM

Escalate IMMEDIATELY if:

### 1. STUCK >30 MINUTES
**Trigger:** Can't solve a problem in >30 min  
**Action:** Come to chat with details  

### 2. CRITICAL BUG FOUND
**Trigger:** Feature is broken (happy path fails)  
**Action:** Stop work, escalate with details  

### 3. FEATURE NOT WORKING
**Trigger:** Feature tested, but doesn't work as expected  
**Action:** Test more + escalate if unsolvable  

### 4. PERFORMANCE ISSUE
**Trigger:** Page load >3 seconds or database slow  
**Action:** Check logs + escalate  

### 5. DATA NOT SAVING
**Trigger:** Data entered but not saved to database  
**Action:** Check database + workflows + escalate  

### 6. WORKFLOW NOT TRIGGERING
**Trigger:** Workflow set up but not running  
**Action:** Check triggers + escalate  

### 7. DATABASE ERROR
**Trigger:** Error in Bubble logs related to database  
**Action:** Screenshot error + escalate  

### 8. PLUGIN NOT WORKING
**Trigger:** Stripe/email/other plugin failing  
**Action:** Check configuration + escalate  

---

## 🎯 HOW TO ESCALATE

### Step 1: Document the Problem
```
🚩 ESCALATION: [Problem Name]

What I was trying:
- [Description of task]

What I did:
1. [Step 1]
2. [Step 2]
3. [Step that failed]

Error message:
[Screenshot or text]

Current status:
- [Is it affecting user flow?]
- [Is it blocking other work?]

Time spent:
- [X minutes]
```

### Step 2: Come to Chat
Post the documented problem in our chat.

### Step 3: Wait for Response
- Expect response <1 hour
- Could be:
  - Quick fix (continue with Sonnet)
  - Escalate to Opus (higher reasoning power)
  - Architecture change needed

### Step 4: Implement Fix
Follow guidance and test thoroughly before continuing.

### Step 5: Document in AUDIT-LOG
After resolved:
```markdown
### Escalation: [Name]
Date: YYYY-MM-DD
Issue: [Description]
Resolution: [What fixed it]
Tokens spent: ~[X] (Opus)
Result: ✅ Resolved
```

---

## 📊 ESCALATION DECISION TREE

```
Problem encountered?
├─ Can solve in <30 min?
│  ├─ YES → Keep working
│  └─ NO → Escalate
│
├─ Is it critical? (breaks happy path)
│  ├─ YES → Escalate immediately
│  └─ NO → Try 30 min, then escalate if stuck
│
└─ Unsure?
   └─ Escalate (better safe than blocked)
```

---

## 🚨 PRIORITY LEVELS

### CRITICAL (Escalate NOW)
- Breaks happy path (login, signup, profiles)
- Blocking multiple features
- Data loss
→ Escalate immediately, don't wait

### HIGH (Escalate in 30 min)
- Feature not working but not critical path
- Performance issue (>3s load)
- Data not saving
→ Try fix for 30 min, escalate if stuck

### MEDIUM (Try 1 hour)
- Minor feature issue
- UI layout problem
- Cosmetic bug
→ Try fix for 1 hour, escalate if stuck

### LOW (Can wait)
- Nice-to-have feature
- Can workaround
- Non-blocking issue
→ Log it, continue with other tasks

---

## 📋 ESCALATION LOG TEMPLATE

In AUDIT-LOG.md, log all escalations:

```markdown
## Escalations - Week X

### 1. [Issue Name]
- **Date:** YYYY-MM-DD
- **Severity:** Critical / High / Medium / Low
- **Description:** [Brief description]
- **Time to resolve:** [X minutes]
- **Model used:** Sonnet 4.5 → Opus 4.5
- **Tokens spent:** ~[X]
- **Result:** ✅ Resolved / ⏳ In progress

### 2. [Next issue...]
```

---

## 🎯 ESCALATION SUCCESS

**Good escalation:**
- ✅ Clear problem description
- ✅ Error messages/screenshots
- ✅ Steps already tried
- ✅ Time spent
- ✅ Impact assessment

**Bad escalation:**
- ❌ "It's broken"
- ❌ No error details
- ❌ No attempt to troubleshoot
- ❌ Vague description

---

## ⏱️ RESPONSE TIMES

**When you escalate:**
- Expect response within 1 hour
- If Sonnet can fix: continue with Sonnet
- If needs Opus: I'll jump to Opus
- If architectural: we discuss + decide

**Don't:**
- ❌ Wait >30 min without escalating
- ❌ Give up and skip task
- ❌ Work around critical bugs

**Do:**
- ✅ Escalate early
- ✅ Provide good detail
- ✅ Be ready to implement fix quickly

---

**Document Version:** 1.0  
**Status:** READY FOR USE
