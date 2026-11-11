# Start here: launch runbook

Everything that can be prepared in advance has been. What remains are the steps only the owner can do: opening accounts, choosing dates, and talking to people. Work down the list in order.

Estimated effort to first sale: about 12 hours of setup spread over a week, then the six-week plan in `marketing/launch-plan.md`.

## What is already done

| Piece | Where | State |
|---|---|---|
| Decisions on format, price, curriculum, brand, channels | `plan/02-decisions.md` | Decided, with reasons. Change any you disagree with. |
| Course content: 7 modules, 7 worksheets, prompts, case study | `course/` | Complete and teachable as written |
| Facilitator guide for the six live calls | `course/facilitator-guide.md` | Complete |
| Website with waitlist form and free guide | `site/` | Built; needs deploying |
| Emails: waitlist, enrolment, onboarding | `marketing/email-sequences.md` | Written; need pasting into an email tool |
| Outreach messages, posts, talk script | `marketing/` | Written |
| Legal drafts | `plan/05-legal-templates.md`, `site/privacy.html`, `site/terms.html` | Drafts; need your details and a lawyer's review |

## Step 1. Review the decisions (30 minutes)

- [ ] Read `plan/02-decisions.md`. The two that matter most are the price ($297 pilot) and the format (six weeks with a weekly live call).
- [ ] If you change the price, update `site/config.js` and `plan/03-pricing-and-model.md`.

## Step 2. Put the website online (1–2 hours)

- [ ] Preview it locally: `cd site && python3 -m http.server 8000`
- [ ] Register a domain name.
- [ ] Deploy to Netlify following `plan/04-tech-stack.md` ("Deploying the site"). The repository already contains `netlify.toml`.
- [ ] Submit the waitlist form once yourself and confirm that the entry appears in Netlify under Forms.
- [ ] Turn on email notifications for new form entries.

## Step 3. Test launch now, real details later

The site ships in test mode: `testMode: true` in `site/config.js`. In test mode every page shows a "Test version" banner, search engines are asked not to list the site, and the Privacy and Terms pages show stand-in business details. You can deploy and collect a test waitlist like this.

Before the real launch:

- [ ] In `site/config.js`, fill in `business` (legal name, location, contact email, providers, date) and set `testMode: false`. That is the only file to edit.
- [ ] Work through the checklist at the end of `plan/05-legal-templates.md`.
- [ ] Have a lawyer review the privacy page, the terms and the refund policy before you take payment.
- [ ] Do not paste a payment link into `checkoutUrl` while `testMode` is true.

## Step 4. Set up email (2 hours)

- [ ] Open an account with an email tool (see `plan/04-tech-stack.md`).
- [ ] Connect the waitlist form to it, or import new entries by hand each day while numbers are small.
- [ ] Paste in sequence A from `marketing/email-sequences.md` as an automation that starts on sign-up.
- [ ] Sign up with your own address and check that all three emails arrive and every link works.

## Step 5. Start filling the waitlist (weeks 1–3)

- [ ] Follow `marketing/launch-plan.md` week by week. Start with the list of 50 people and script A in `marketing/outreach-scripts.md`.
- [ ] Book the first free info session and run it from `marketing/info-session.md`.
- [ ] Keep the weekly scorecard in the launch plan.

## Step 6. Open enrolment (week 4, 2 hours)

- [ ] Choose the cohort start date and the day and time of the weekly call.
- [ ] Create a payment link for $297 with your payment provider.
- [ ] In `site/config.js`, paste the link into `checkoutUrl` and set `cohortStart`. Every button on the site now leads to checkout.
- [ ] Buy a place yourself as a test, then refund it.
- [ ] Send sequence B from `marketing/email-sequences.md`, filling in the date, time and link.

## Step 7. Deliver the course (6 weeks)

- [ ] Share the course with learners. For twelve people, a shared folder with one document per module is enough: copy the modules and worksheets from `course/`.
- [ ] Send sequence C (welcome and weekly emails).
- [ ] Offer each learner a 15-minute tech check before week 1.
- [ ] Run the six calls from `course/facilitator-guide.md`. Record them; the recordings become the video library for the self-paced version.

## Step 8. After the cohort

- [ ] Send the feedback form and testimonial consent (questions in the facilitator guide; consent wording in `plan/05-legal-templates.md`).
- [ ] Follow up at 30 and 60 days and record how many learners have held a paid call.
- [ ] Add real testimonials to the site, with consent.
- [ ] Decide the price and date of cohort 2 using `plan/03-pricing-and-model.md`.

## What is deliberately not here

- **Video lessons.** Record the live calls first; do not produce video before the content has been taught once.
- **A course platform.** Not needed for twelve people. Move to one for the self-paced version.
- **A marketplace.** Parked as Phase 2; see `plan/02-decisions.md`.
- **Testimonials.** There are none yet. The site labels Linda and Marcus as an illustration and makes no income claims. Keep it that way until real results exist.
