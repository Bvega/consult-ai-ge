# Week 1: Core Infrastructure & Auth
## Day-by-Day Breakdown

**Week 1 Goal:** Auth works, profiles created, 0 critical bugs  
**Success Criteria:** Stage gate GO to Week 2  
**Model:** Claude Sonnet 4.5 (primary)  
**Budget:** ~2K tokens

---

## DAY 1-2: Bubble Workspace + Database Schema

### Morning (Day 1)
**Task 1.1: Create Bubble Workspace (2 hrs)**
- [ ] Go to https://bubble.io
- [ ] Create account (if needed)
- [ ] Create app: `consult-ai-ge`
- [ ] Set to Production environment
- [ ] Enable Git-like versioning (Settings → Version control)
- [ ] Create 2 products in Stripe (if using):
  - Product 1: Consultant ($5/month)
  - Product 2: Client ($20/month)

**Commit:** "Week 1, Day 1: Bubble workspace created (Claude Sonnet 4.5, ~150 tokens)"

**Task 1.2: Create 8 Database Tables (4 hrs)**
- [ ] Users table (email, password_hash, name, role, created_at, stripe_customer_id, verified)
- [ ] Consultants table (user_id, expertise_tags, years_experience, hourly_rate, availability_hours, bio, linkedin_url, stripe_account_id, rating, review_count, profile_complete)
- [ ] Clients table (user_id, company_name, industry, budget_min, budget_max, project_description, profile_complete)
- [ ] Matches table (consultant_id, client_id, matched_date, status, matching_score)
- [ ] Bookings table (consultant_id, client_id, match_id, hours, rate, total_amount, booking_date, status, stripe_payment_intent_id, paid, payout_processed, payout_date)
- [ ] Messages table (from_user_id, to_user_id, booking_id, message_text, created_at, read)
- [ ] Reviews table (booking_id, from_user_id, to_user_id, rating, review_text, created_at)
- [ ] Subscriptions table (user_id, plan, stripe_subscription_id, status, renewal_date, created_at)

**Success:** All 8 tables created, verified in Bubble database

**Commit:** "Week 1, Day 1-2: Database schema created (8 tables) (Claude Sonnet 4.5, ~200 tokens)"

---

## DAY 2-3: User Authentication

### Afternoon (Day 2) + Morning (Day 3)
**Task 2.1: Signup Flow - Consultant (3 hrs)**
- [ ] Create page: `signup-consultant`
- [ ] Add form: email, password
- [ ] Add validation: email unique, password >8 chars
- [ ] On submit: Create User record (role: consultant), send verification email

**Task 2.2: Signup Flow - Client (2 hrs)**
- [ ] Create page: `signup-client`
- [ ] Add form: email, password
- [ ] On submit: Create User record (role: client), send verification email

**Task 2.3: Email Verification (2 hrs)**
- [ ] Create verification link workflow
- [ ] User clicks link → verified=true in Users table
- [ ] Redirect to profile-consultant or profile-client

**Task 2.4: Login Flow (2 hrs)**
- [ ] Create page: `login`
- [ ] Add form: email, password
- [ ] On submit: Authenticate, redirect to dashboard

**Task 2.5: Password Reset (2 hrs)**
- [ ] Create page: `password-reset`
- [ ] Email flow: send reset link
- [ ] Reset page: new password form

**Success:** Signup, verify, login work end-to-end

**Commit:** "Week 1, Day 2-3: Authentication implemented (signup/login/reset) (Claude Sonnet 4.5, ~300 tokens)"

---

## DAY 4: Email Notifications Setup

### Full Day
**Task 3.1: Email Templates (3 hrs)**
- [ ] Verification email template
- [ ] Password reset email template
- [ ] Booking confirmation email
- [ ] Payout notification email
- [ ] Matching notification email

**Task 3.2: Email Triggers (3 hrs)**
- [ ] Trigger 1: Send verification on signup
- [ ] Trigger 2: Send reset link on "forgot password"
- [ ] Trigger 3: Send confirmation on booking
- [ ] Trigger 4: Send payout notification

**Task 3.3: Test Email Delivery (2 hrs)**
- [ ] Send test email to yourself
- [ ] Verify HTML rendering
- [ ] Check spam folder
- [ ] Verify links work

**Success:** All emails deliver correctly

**Commit:** "Week 1, Day 4: Email notifications setup (Claude Sonnet 4.5, ~200 tokens)"

---

## DAY 5: Profile Creation (Consultant + Client)

### Full Day
**Task 4.1: Consultant Profile Form (4 hrs)**
- [ ] Create page: `profile-consultant`
- [ ] Form fields: expertise_tags, years_experience, hourly_rate, availability_hours, bio, linkedin_url
- [ ] Validation: all required except linkedin_url
- [ ] On submit: Create Consultants record + set profile_complete=true

**Task 4.2: Client Profile Form (4 hrs)**
- [ ] Create page: `profile-client`
- [ ] Form fields: company_name, industry, budget_min, budget_max, project_description
- [ ] Validation: all required
- [ ] On submit: Create Clients record + set profile_complete=true

**Task 4.3: Profile Preview Pages (2 hrs)**
- [ ] Consultant preview: show filled profile
- [ ] Client preview: show filled profile
- [ ] "Edit" button: back to form
- [ ] "Continue" button: save & redirect

**Success:** Profiles created, saved correctly, preview works

**Commit:** "Week 1, Day 5: Profile creation (consultant + client) (Claude Sonnet 4.5, ~300 tokens)"

---

## END OF WEEK 1: STAGE GATE

**Checklist Before Gate Decision:**
- [ ] Bubble workspace created + versioning enabled
- [ ] All 8 tables created + verified
- [ ] Signup (consultant + client) works end-to-end
- [ ] Email verification works
- [ ] Login works + redirects to correct dashboard
- [ ] Password reset works
- [ ] All 5 email templates created + tested
- [ ] Email delivery verified (no spam)
- [ ] Consultant profile form works + saves correctly
- [ ] Client profile form works + saves correctly
- [ ] Profile preview pages work
- [ ] 0 critical bugs on happy path

**Gate Decision: GO to Week 2? ✅ / HOLD ❌**

---

**Document Version:** 1.0  
**Week:** 1 of 4  
**Status:** READY FOR DEVELOPER LLM
