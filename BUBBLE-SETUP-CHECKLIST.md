# Bubble Setup Checklist
## Pre-Development Verification

**Status:** Ready  
**Last Updated:** 2026-09-19

---

## ✅ ACCOUNT SETUP

- [ ] Bubble account created (https://bubble.io)
- [ ] Email verified
- [ ] App created: `consult-ai-ge`
- [ ] App set to Production environment
- [ ] Personal profile updated (if needed)

---

## ✅ APP CONFIGURATION

- [ ] Version control enabled (Settings → Version control)
- [ ] Test database backup created
- [ ] Privacy rules set (users only see own data)
- [ ] CORS configured (if needed)

---

## ✅ PLUGINS INSTALLED

- [ ] Stripe Connector (for payments)
- [ ] Bubble Messenger (optional, for messaging)
- [ ] SendGrid (optional, for advanced email)

**How to install:**
1. Bubble Editor → Plugins
2. Click "Add plugins"
3. Search plugin name
4. Click "Install"

---

## ✅ STRIPE SETUP (Week 3)

**Test Mode (Week 1-3):**
- [ ] Stripe account created (https://stripe.com)
- [ ] Test mode enabled
- [ ] 2 products created:
  - Product: "Consultant" ($5/month, product_id: xxx)
  - Product: "Client" ($20/month, product_id: yyy)
- [ ] API keys obtained:
  - Publishable Key (test)
  - Secret Key (test)
- [ ] Keys added to Bubble Stripe Connector

**Note:** Will switch to LIVE mode Week 4

---

## ✅ EMAIL SETUP

- [ ] Bubble email configured (Settings → Email)
- [ ] Sender address set
- [ ] SMTP verified (if using custom SMTP)
- [ ] Test email sent successfully

---

## ✅ DATABASE SETUP

- [ ] All 8 tables created
- [ ] All fields defined (with correct types)
- [ ] Indexes created on frequently-searched fields:
  - Users.email
  - Consultants.expertise_tags
  - Bookings.status
- [ ] Privacy rules set (Users.current_user only)

---

## ✅ PAGES CREATED

**Core Pages:**
- [ ] index (homepage)
- [ ] signup-consultant
- [ ] signup-client
- [ ] login
- [ ] password-reset

**Profile Pages:**
- [ ] profile-consultant
- [ ] profile-client

**Dashboard Pages:**
- [ ] dashboard-consultant
- [ ] dashboard-client

**Other Pages:**
- [ ] consultant-detail
- [ ] messages
- [ ] admin-dashboard (Bolivar only)

---

## ✅ WORKFLOWS SETUP

- [ ] Signup consultant workflow
- [ ] Signup client workflow
- [ ] Email verification workflow
- [ ] Password reset workflow
- [ ] Login workflow
- [ ] Profile save workflows

---

## 📋 TESTING CHECKLIST

**Signup Flow:**
- [ ] Can signup as consultant
- [ ] Email verification works
- [ ] Can signup as client
- [ ] Can login with correct credentials
- [ ] Cannot login with wrong password
- [ ] Password reset works

**Profiles:**
- [ ] Consultant profile form saves correctly
- [ ] Client profile form saves correctly
- [ ] Profile preview shows correct data
- [ ] Can edit profile

**Emails:**
- [ ] Verification email arrives
- [ ] Verification link works
- [ ] Reset email arrives
- [ ] Reset link works
- [ ] No duplicate emails

**Performance:**
- [ ] Homepage loads <2 seconds
- [ ] Signup page <2 seconds
- [ ] Database queries efficient (check debugger)

---

## 🔴 RED FLAGS

If any of these occur, escalate immediately:
- [ ] Page load time >3 seconds
- [ ] Database errors in logs
- [ ] Email not sending
- [ ] Workflow not triggering
- [ ] Data not saving
- [ ] Stripe integration failing

---

## ✨ READY FOR WEEK 1?

When ALL boxes checked:
- [ ] Click "Ready for Week 1 Start" below
- [ ] Commit to GitHub
- [ ] Notify Bolivar

**Ready?** ✅ GO to Week 1 Day 1 / ❌ HOLD & FIX

---

**Document Version:** 1.0  
**Status:** CHECKLIST COMPLETE
