# Decisions: the brief's open questions, answered

The brief left five questions open. Each one is answered here with a recommended default so the project can launch without further planning. Every default can be changed; the "What changes if you disagree" line says which files to touch.

## 1. Format: hybrid, starting with a live pilot cohort

**Decision.** Self-paced written modules plus one 60-minute live group call per week for six weeks. The first run is a small paid pilot ("Founding Cohort", 12 seats).

**Why.**
- The learners are not tech-native. A weekly call where someone can share their screen and get unstuck is the difference between finishing and quietly dropping out.
- A pilot lets you sell before recording any video. The written modules in `course/` are enough to teach from; record the live calls and they become the video library for the self-paced version.
- Twelve people is small enough to give everyone attention and large enough to yield testimonials and case studies.

**What changes if you disagree.** For pure self-paced, drop the "Live calls" section from `site/index.html` and ignore `course/facilitator-guide.md`.

## 2. Pricing: one-time fee, three steps

| Offer | Price | When |
|---|---|---|
| Founding Cohort (pilot, 12 seats, live calls) | $297 | Launch |
| Self-paced course | $397 | After the pilot |
| Course + live cohort | $697 | Cohort 2 onward |

**Why.** A one-time fee is easy for this audience to understand and trust; a subscription invites "what am I paying for each month?" The pilot is priced low on purpose and in exchange for feedback and a testimonial. The promise that anchors the price: the course is designed to get the learner to one paid advisory call, and a single call at the suggested starter rate ($150–$250) recovers most of the fee.

These prices are starting assumptions, not market research. See `plan/03-pricing-and-model.md` for the arithmetic and how to test them.

**What changes if you disagree.** Prices appear in `site/config.js` (one line) and `plan/03-pricing-and-model.md`.

## 3. Marketplace: not now

**Decision.** Keep version one purely educational. Do not build a matching layer.

**Why.** A marketplace needs both sides at once and is a software project. The course needs neither. The course also creates the marketplace's supply: every graduate leaves with a published offer. Once there are roughly 50 graduates with live offers, a simple public directory page ("Find an advisor") is the cheap first test of demand from the "Marcus" side.

The earlier marketplace plan already in this repository (`docs/`, `bubble-app/`, the `WEEK-*` and `AUDIT-*` files) is parked as Phase 2, unchanged.

## 4. Curriculum: seven modules over six weeks

Module 0 is setup, done before week one. Modules 1–6 map onto the five teaching areas in the brief, with "packaging" given its own week because it produces the most tangible output.

| Week | Module | Learner leaves with |
|---|---|---|
| Pre-work | 0. Welcome and setup | A working AI assistant and the four safety rules |
| 1 | 1. Mine your experience | A bank of five real stories |
| 2 | 2. From stories to frameworks | One named framework and a checklist |
| 3 | 3. Package it | A one-page PDF and a one-page website |
| 4 | 4. Position it | A one-sentence offer and a profile that says it |
| 5 | 5. Work across generations | Three conversations with younger professionals |
| 6 | 6. Your first paid call | A price, a booking link, and a call plan |

Full content is in `course/`.

## 5. Brand: warm, plain, and legible

Name stays **Consult AI-ge** (said "consult-age"). Tagline: **"Your experience, made visible."** Palette, type and voice are in `brand/brand-guide.md`; the logo is `site/assets/logo.svg`.

## 6. Marketing channels: go where retirees already gather

Priority order, with reasons, in `marketing/launch-plan.md`:

1. Your own network and LinkedIn (personal invitations)
2. Professional associations' retiree and alumni groups
3. Lifelong-learning programmes, libraries and community groups (free talks)
4. Adult children and former colleagues ("this is for your mum / your old boss")
5. Paid ads, only after the pilot has produced testimonials
