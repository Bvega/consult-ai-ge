# Daily Workflow: Developer LLM
## How You Work Each Day

---

## 🌅 MORNING (30 min)

### 1. Read Today's Task (15 min)
Open `WEEK-1-TASKS.md` → Find your day's section

### 2. Review Checklist (10 min)
- [ ] What needs to be done?
- [ ] How long will it take?
- [ ] What could go wrong?

### 3. Quick Status Update (5 min)
"Morning - Starting [Task]. Will update at EOD."

---

## 👨‍💻 WORK DAY (6-8 hours)

### Workflow
1. **Execute task in Bubble** (main work)
   - Click UI elements
   - Create workflows
   - Configure plugins
   - Test as you go

2. **Test frequently** (not just at end)
   - Bubble preview mode after each step
   - Look for errors in logs
   - Test happy path + edge cases

3. **Document as you go**
   - Take notes if anything is confusing
   - Screenshot errors (for escalation)
   - Mark checkboxes in task list as you complete them

4. **Reach out if stuck** (>30 min)
   - Don't spin wheels
   - Come to chat
   - Explain: tried X, got error Y, need help with Z
   - Could escalate to Opus

---

## 🌆 END OF DAY (1 hour)

### 1. Final Testing (20 min)
- [ ] Test everything you built today
- [ ] Check for errors in Bubble logs
- [ ] Verify data saved correctly
- [ ] Take screenshots of working features

### 2. Update Task Checklist (5 min)
In `WEEK-1-TASKS.md`:
- Mark ✅ for completed items
- Mark ❌ if blocked
- Mark 🔄 if in progress

### 3. Git Commit (10 min)
```bash
cd C:\Users\boliv\consult-ai-ge
git add .
git commit -m "Week X, Day Y: [Task description] (Claude Sonnet 4.5, ~150 tokens)"
git push origin main
```

### 4. Report Progress (15 min)
Come to chat and report:

**Format:**
```
## Day X Report

✅ Completed:
- [Task 1]
- [Task 2]

⏳ In Progress:
- [Task 3]

🚧 Blockers:
- [If any]

📊 Tokens spent today: ~X (estimate)
Model used: Sonnet 4.5

Ready for Day X+1? ✅ YES / ❌ NEED HELP
```

---

## 🔄 WEEKLY GATE (Friday EOD)

### Submit Weekly Report

**Template:**
```markdown
## Week X Model Report (Date: YYYY-MM-DD)

### Summary
- Days completed: X/5
- Model: Claude Sonnet 4.5
- Escalations: 0
- Tokens spent: ~XK
- Quality: ⭐⭐⭐⭐⭐

### Day-by-Day Breakdown
- Day 1: [Task] ✅ (Sonnet, ~150 tokens)
- Day 2: [Task] ✅ (Sonnet, ~200 tokens)
- Day 3: [Task] ✅ (Sonnet, ~250 tokens)
- Day 4: [Task] ✅ (Sonnet, ~200 tokens)
- Day 5: [Task] ✅ (Sonnet, ~250 tokens)

### Success Criteria Met
- [x] Auth works end-to-end
- [x] Profiles created + saved
- [x] Emails send correctly
- [x] 0 critical bugs
- [x] All tests passed

### Escalations
- None

### Notes
Sonnet 4.5 handled all tasks smoothly. No issues.

### Ready for Week X+1?
✅ GO
```

---

## 📋 DAILY CHECKLIST

### Morning
- [ ] Read today's task
- [ ] Understand what needs to be done
- [ ] Know how long it should take

### During Day
- [ ] Execute in Bubble
- [ ] Test frequently
- [ ] Document progress
- [ ] Escalate if stuck >30 min

### Evening
- [ ] Final testing
- [ ] Update task checklist
- [ ] Commit to GitHub (with model info)
- [ ] Report progress in chat

### Friday (Additional)
- [ ] Compile weekly report
- [ ] Submit report by EOD
- [ ] Be ready for gate decision Monday

---

## 🆘 WHEN STUCK

**If task takes >30 min and you're blocked:**

1. **Stop working on that task**
2. **Document the problem:**
   - What you tried
   - What error you got
   - Screenshot (if applicable)
   - What you need help with

3. **Come to chat:**
```
🆘 BLOCKED: [Task Name]

Tried: [Description]
Error: [Screenshot/description]
Need: [Help type]
```

4. **Wait for response** (usually <1 hour)

**Don't:**
- ❌ Spin wheels for hours
- ❌ Skip testing
- ❌ Make commitments without testing

**Do:**
- ✅ Escalate early (wasted time is wasted money)
- ✅ Test thoroughly
- ✅ Communicate progress
- ✅ Follow checklist

---

**Document Version:** 1.0  
**Status:** READY FOR USE
