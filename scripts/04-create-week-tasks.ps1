# ============================================================
# 04-create-week-tasks.ps1
# Genera WEEK-X-TASKS.md para la semana siguiente automáticamente.
# USO: .\scripts\04-create-week-tasks.ps1 -Week 2
# ============================================================

param(
    [Parameter(Mandatory)][int]$Week
)

. "$PSScriptRoot\config.ps1"
. "$PSScriptRoot\functions.ps1"

$date    = Get-Date -Format "yyyy-MM-dd"
$outFile = "$REPO_ROOT\WEEK-$Week-TASKS.md"

Write-Title "04-CREATE-WEEK-TASKS — Week $Week"
Assert-Git
Assert-Repo

if (Test-Path $outFile) {
    Write-Warn "WEEK-$Week-TASKS.md ya existe."
    $overwrite = Confirm-Action "¿Sobreescribir?"
    if (-not $overwrite) { exit 0 }
}

# --- Contenido por semana ---
switch ($Week) {

    2 {
        $content = @"
# Week 2: Search, Matching & Messaging
## Day-by-Day Breakdown

**Week 2 Goal:** Search works, matching algorithm live, messaging reliable
**Stage Gate:** Search relevant, algorithm correct, messaging tested
**Model:** $MODEL_PRIMARY (primary)
**Budget:** ~2K tokens

---

## DAY 1-2: Search & Browse

**Task 1.1: Consultant Search Page (4 hrs)**
- [ ] Create page: \`search-consultants\`
- [ ] Add search bar: keyword + expertise filter
- [ ] Results list: name, expertise, rate, rating
- [ ] Pagination: 10 results per page
- [ ] Link each result to \`consultant-detail\` page

**Task 1.2: Consultant Detail Page (3 hrs)**
- [ ] Show full profile: bio, expertise, rate, availability
- [ ] Show reviews + average rating
- [ ] Button: "Request Booking"

**Commit:** "Week 2, Day 1-2: Search + consultant detail ($MODEL_PRIMARY, ~250 tokens)"

---

## DAY 2-3: Matching Algorithm

**Task 2.1: 100-Point Matching Scorer (4 hrs)**
- [ ] Implement scoring in Bubble backend workflow:
  - Expertise match     : 40 pts
  - Experience level    : 25 pts
  - Budget range match  : 20 pts
  - Availability match  : 15 pts
- [ ] Run on every new Client profile save
- [ ] Store top 5 matches in Matches table

**Task 2.2: Client Dashboard - Matches Panel (3 hrs)**
- [ ] Show top 5 matches on dashboard-client
- [ ] Each card: name, score, expertise, rate
- [ ] "Request Booking" button per match

**Commit:** "Week 2, Day 2-3: Matching algorithm + client dashboard ($MODEL_PRIMARY, ~300 tokens)"

---

## DAY 4: Messaging

**Task 3.1: Messages Page (4 hrs)**
- [ ] Create page: \`messages\`
- [ ] Thread list: left panel (all conversations)
- [ ] Message view: right panel (selected thread)
- [ ] Send message form: text input + send button
- [ ] Store in Messages table (from_user_id, to_user_id, text, created_at)

**Task 3.2: Email Notification on New Message (2 hrs)**
- [ ] Trigger email when new message received
- [ ] Email: "You have a new message from [Name]"
- [ ] Link to messages page

**Task 3.3: Read/Unread Status (2 hrs)**
- [ ] Mark messages as read when viewed
- [ ] Show unread count badge in nav

**Commit:** "Week 2, Day 4: Messaging system ($MODEL_PRIMARY, ~250 tokens)"

---

## DAY 5: Notifications + Polish

**Task 4.1: Match Notification Email (2 hrs)**
- [ ] Trigger when new match created
- [ ] Email to client: "We found a match for you: [Name]"
- [ ] Link to consultant detail page

**Task 4.2: Nav Bar Polish (2 hrs)**
- [ ] Add nav to all pages: logo, search, messages, profile, logout
- [ ] Active state on current page
- [ ] Unread messages badge

**Task 4.3: Week 2 Testing (3 hrs)**
- [ ] Test search: finds relevant consultants
- [ ] Test matching: score calculated correctly
- [ ] Test messaging: thread creates, messages send/receive
- [ ] Test notifications: emails arrive
- [ ] 0 critical bugs

**Commit:** "Week 2, Day 5: Notifications + polish + testing ($MODEL_PRIMARY, ~200 tokens)"

---

## END OF WEEK 2: STAGE GATE

- [ ] Search finds relevant consultants
- [ ] Matching algorithm scores correctly (test with 3 profiles)
- [ ] Messages send and receive correctly
- [ ] Email notifications arrive
- [ ] Client dashboard shows top 5 matches
- [ ] 0 critical bugs

**Gate Decision: GO to Week 3? ✅ / HOLD ❌**

---

**Document Version:** 1.0
**Week:** 2 of 4
**Generated:** $date
"@
    }

    3 {
        $content = @"
# Week 3: Payments, Bookings & Reviews
## Day-by-Day Breakdown

**Week 3 Goal:** Stripe integrated, bookings flow complete, reviews working
**Stage Gate:** 0 payment errors, booking creates, payout triggers
**Model:** $MODEL_PRIMARY (primary)
**Budget:** ~2K tokens

---

## DAY 1-2: Stripe Subscriptions

**Task 1.1: Stripe Connector Setup (2 hrs)**
- [ ] Verify Stripe plugin configured (from Week 1)
- [ ] Confirm test API keys active
- [ ] Test connection: Bubble → Stripe

**Task 1.2: Consultant Subscription ($5/mo) (3 hrs)**
- [ ] On signup completion: redirect to subscribe-consultant
- [ ] Stripe Checkout: Product "Consultant" ($5/month)
- [ ] On success: update Subscriptions table (status: active)
- [ ] On fail: show error + retry option

**Task 1.3: Client Subscription ($20/mo) (3 hrs)**
- [ ] On signup completion: redirect to subscribe-client
- [ ] Stripe Checkout: Product "Client" ($20/month)
- [ ] On success: update Subscriptions table (status: active)
- [ ] On fail: show error + retry option

**Commit:** "Week 3, Day 1-2: Stripe subscriptions ($MODEL_PRIMARY, ~300 tokens)"

---

## DAY 3: Booking Flow

**Task 2.1: Booking Request (3 hrs)**
- [ ] "Request Booking" triggers booking form modal
- [ ] Form: hours requested, preferred date, notes
- [ ] Calculate total: hours × consultant rate
- [ ] On submit: Create Bookings record (status: pending)
- [ ] Notify consultant by email: "New booking request"

**Task 2.2: Consultant Accepts/Declines (3 hrs)**
- [ ] On dashboard-consultant: pending bookings panel
- [ ] Accept button: status → confirmed, notify client
- [ ] Decline button: status → declined, notify client
- [ ] Auto-expire pending after 48 hours

**Task 2.3: Payment on Confirmation (2 hrs)**
- [ ] On accept: trigger Stripe payment for total amount
- [ ] On success: status → paid, store stripe_payment_intent_id
- [ ] On fail: status → payment_failed, notify client

**Commit:** "Week 3, Day 3: Booking flow + payments ($MODEL_PRIMARY, ~300 tokens)"

---

## DAY 4: Payouts (85%)

**Task 3.1: Stripe Connect for Consultants (3 hrs)**
- [ ] Consultant onboarding: Stripe Connect Express
- [ ] Store stripe_account_id in Consultants table
- [ ] Verify account status before payout

**Task 3.2: Payout Trigger (3 hrs)**
- [ ] On booking status = paid: schedule payout
- [ ] Payout = 85% of total (platform keeps 15%)
- [ ] Transfer to consultant Stripe account
- [ ] Update Bookings: payout_processed=true, payout_date=today

**Task 3.3: Payout Email (1 hr)**
- [ ] Email to consultant: "Your payout of \$X has been sent"

**Commit:** "Week 3, Day 4: 85% payouts + Stripe Connect ($MODEL_PRIMARY, ~250 tokens)"

---

## DAY 5: Reviews

**Task 4.1: Post-Booking Review Flow (3 hrs)**
- [ ] On booking complete: email client "Leave a review"
- [ ] Review page: 1-5 star rating + text (max 300 chars)
- [ ] Store in Reviews table
- [ ] Update Consultants.rating (recalculate average)
- [ ] Update Consultants.review_count

**Task 4.2: Reviews Display (2 hrs)**
- [ ] Show reviews on consultant-detail page
- [ ] Average rating + review count
- [ ] Latest 5 reviews visible

**Task 4.3: Week 3 Testing (3 hrs)**
- [ ] Test subscription: both plans checkout correctly
- [ ] Test booking: request → accept → payment
- [ ] Test payout: 85% transferred correctly
- [ ] Test review: submits, updates average
- [ ] 0 payment errors

**Commit:** "Week 3, Day 5: Reviews + full payment test ($MODEL_PRIMARY, ~200 tokens)"

---

## END OF WEEK 3: STAGE GATE

- [ ] Subscriptions: both plans work in test mode
- [ ] Booking flow: request → accept → pay
- [ ] Payouts: 85% transfers correctly
- [ ] Reviews: submit, display, average update
- [ ] 0 payment errors in test mode
- [ ] All emails send correctly

**Gate Decision: GO to Week 4? ✅ / HOLD ❌**

---

**Document Version:** 1.0
**Week:** 3 of 4
**Generated:** $date
"@
    }

    4 {
        $content = @"
# Week 4: Admin Dashboard, Polish & Launch
## Day-by-Day Breakdown

**Week 4 Goal:** Admin works, polish done, LAUNCH on Day 5
**Stage Gate:** UAT pass → Stripe LIVE → Public launch
**Model:** $MODEL_PRIMARY (primary)
**Budget:** ~2K tokens

---

## DAY 1-2: Admin Dashboard

**Task 1.1: Admin Panel (Bolivar only) (4 hrs)**
- [ ] Create page: \`admin-dashboard\` (role: admin only)
- [ ] Panels:
  - Total consultants (active / pending)
  - Total clients (active)
  - Revenue this month (subscriptions + 15% commissions)
  - Pending bookings
  - Flagged reviews

**Task 1.2: User Management (3 hrs)**
- [ ] List all users (search by name/email)
- [ ] Suspend / reactivate user
- [ ] View user's bookings + reviews

**Task 1.3: Revenue Tracking (2 hrs)**
- [ ] Monthly revenue chart (subscriptions + commissions)
- [ ] Export CSV: bookings this month

**Commit:** "Week 4, Day 1-2: Admin dashboard ($MODEL_PRIMARY, ~250 tokens)"

---

## DAY 3: Polish & Edge Cases

**Task 2.1: Error States (3 hrs)**
- [ ] Empty state: no matches found
- [ ] Empty state: no messages
- [ ] Empty state: no bookings
- [ ] 404 page
- [ ] Payment failed page

**Task 2.2: Mobile Responsive Check (3 hrs)**
- [ ] Test all pages on mobile breakpoint in Bubble
- [ ] Fix any layout issues
- [ ] Test forms on mobile

**Task 2.3: Performance Check (2 hrs)**
- [ ] All pages load <2 seconds
- [ ] Search results <1 second
- [ ] Database queries optimized

**Commit:** "Week 4, Day 3: Polish + edge cases ($MODEL_PRIMARY, ~200 tokens)"

---

## DAY 4: UAT (User Acceptance Testing)

**Bolivar runs full UAT:**
- [ ] Create consultant account end-to-end
- [ ] Create client account end-to-end
- [ ] Search for consultant
- [ ] Request booking
- [ ] Accept booking + payment
- [ ] Leave review
- [ ] Check admin dashboard
- [ ] All emails arrive correctly
- [ ] 0 critical bugs found

**If UAT passes:**
- [ ] Switch Stripe to LIVE mode (Settings → Stripe keys)
- [ ] Update Stripe keys in Bubble to production keys
- [ ] Test one real \$1 transaction (refund immediately)

**Commit:** "Week 4, Day 4: UAT complete + Stripe LIVE ($MODEL_PRIMARY, ~150 tokens)"

---

## DAY 5: 🚀 LAUNCH

**Morning:**
- [ ] Final check: all features working
- [ ] Confirm: Stripe LIVE mode active
- [ ] Confirm: all emails configured for production
- [ ] Confirm: admin dashboard accessible

**Soft Launch:**
- [ ] Send invites to 50 pre-seeded consultants
- [ ] Monitor: Stripe dashboard (real transactions)
- [ ] Monitor: Bubble logs (errors)
- [ ] Monitor: Email delivery (all arriving)

**Post-Launch (Day 1):**
- [ ] Check: any signup errors
- [ ] Check: any payment errors
- [ ] Check: any email delivery issues
- [ ] Respond to any user issues immediately

**Commit:** "Week 4, Day 5: 🚀 LAUNCH — Consult AI-Ge live ($MODEL_PRIMARY, ~100 tokens)"

---

## 🚀 LAUNCH CRITERIA

ALL must be ✅:
- [ ] Stripe LIVE mode active
- [ ] No critical bugs
- [ ] All emails working
- [ ] Admin dashboard active
- [ ] 50 consultant invites sent
- [ ] Bolivar on standby for support

**LAUNCH DATE: 2026-10-11 🎉**

---

**Document Version:** 1.0
**Week:** 4 of 4
**Generated:** $date
"@
    }

    default {
        Write-Err "Week $Week no tiene template. Solo 2, 3 y 4 están disponibles."
        exit 1
    }
}

# --- Escribir archivo ---
$content | Out-File -FilePath $outFile -Encoding utf8
Write-Ok "Creado: WEEK-$Week-TASKS.md"

# --- Git sync ---
Invoke-GitSync -CommitMsg "Add WEEK-$Week-TASKS.md — ready for build phase ($MODEL_PRIMARY)"

Write-Title "✅ WEEK $Week TASKS CREADO"
Write-Host "  Archivo: $outFile"
Write-Host "  GitHub : $GITHUB_REMOTE"
