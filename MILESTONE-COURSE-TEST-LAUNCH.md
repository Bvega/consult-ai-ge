# Milestone: course test launch is live

**Date:** 2026-11-11
**Status:** Test site live; no real launch steps done yet.
**Live site:** https://consult-ai-ge.netlify.app (Netlify project `consult-ai-ge`, deploys from `main`)

## Where we are

The project brief was turned into a launch-ready course business and the site is deployed in **test mode**. The waitlist form was tested by the owner and works.

| Piece | State |
|---|---|
| Plan, decisions, pricing, legal drafts (`plan/`) | Done |
| Course: 7 modules, 7 worksheets, prompt library, case study, facilitator guide (`course/`) | Done |
| Website with waitlist form and free guide (`site/`) | Live, test mode |
| Emails, outreach, launch plan, info-session script (`marketing/`) | Written, not yet used |
| Brand guide (`brand/`) | Done |
| Netlify Forms | Enabled; form `waitlist` registered |

Defaults chosen (change any in `plan/02-decisions.md`): six weeks with a weekly live call; $297 founding cohort of 12 seats; no marketplace (parked as Phase 2).

Wording decision: the course says "situation" and "experience", not "story".

## What has NOT been done

- Netlify email notifications for new sign-ups (Netlify dashboard, Forms, Form notifications)
- Founder's note in `site/index.html` still the drafted one, needs the owner's own words
- Showing the site to 3–5 people for feedback
- Domain name, email tool, outreach, info session
- `site/config.js`: `testMode` is still `true`; `business` details are stand-ins; no `checkoutUrl`
- Lawyer review of privacy, terms and refund wording; accountant check on tax
- Payment link, cohort start date, weekly call time

## Resume here

Open `START-HERE.md` and continue from step 2 (website live; remaining: notifications, feedback), then steps 4–8. In short:

1. Turn on Netlify form notifications.
2. Send the owner's own founder's note for the home page.
3. Get feedback from a few people: "What is this, and who is it for?"
4. Then domain, email tool, outreach, and finally the real-launch switches in `site/config.js`.

## Notes for whoever continues

- Real details live in one place: `site/config.js`. Set `testMode: false` only after filling in `business`.
- Do not add a payment link while `testMode` is true.
- The older marketplace files (`docs/`, `bubble-app/`, `scripts/`, `AUDIT-*`, `WEEK-*`, the weekly-audit workflow) are unrelated to the course and left untouched.
- Remaining work is mostly small edits; a smaller model is sufficient.

## Pull requests so far

1. #1 Course, site, marketing, plan
2. #2 Fix 404 on the thank-you page
3. #3 Netlify Forms note and redeploy
4. #4 "story" replaced by "situation"
