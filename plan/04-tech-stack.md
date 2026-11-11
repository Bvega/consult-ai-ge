# Tech stack

Chosen for two constraints: the founder should not need to write code, and learners should never be asked to install anything.

## To run the business

| Job | Recommendation | Alternatives | Status |
|---|---|---|---|
| Website | The static site in `site/`, on Netlify | Any static host | Built. Needs deploying. |
| Waitlist form | Netlify Forms (already wired into the page) | Any form tool; paste its embed over the form | Works on deploy |
| Payments | Stripe Payment Link | PayPal, Gumroad | You create the link, paste it into `site/config.js` |
| Email | Any newsletter tool with automations (MailerLite, Kit, Mailchimp) | — | You create the account; copy is in `marketing/email-sequences.md` |
| Live calls | Zoom or Google Meet, with recording on | — | You schedule them |
| Course delivery, pilot | A shared Google Drive folder, or a private page per module | — | Content is in `course/` |
| Course delivery, self-paced | A hosted course platform (Podia, Thinkific, Teachable) | — | After the pilot |
| Community | An email list plus the weekly call. Add a group only if learners ask. | — | Nothing to build |

Why no course platform for the pilot: twelve people can be served from a shared folder and a weekly email. A platform adds a login for learners to lose and a monthly fee before there is revenue.

## How the site switches from waitlist to sales

`site/config.js` holds the sales settings (and the test-mode switch and business details described in `START-HERE.md`, step 3):

```js
window.CONSULT_AIGE = {
  checkoutUrl: "",        // empty = waitlist mode; paste a payment link = sales mode
  price: "$297",
  cohortStart: "",        // e.g. "Monday 11 January"; empty hides the date line
  seats: 12
};
```

While `checkoutUrl` is empty, every button on the page leads to the waitlist form. Paste a payment link and the buttons become "Join the Founding Cohort" and lead to checkout. Nothing else needs editing.

## Deploying the site

1. Create a Netlify account and choose "Import from Git", pointing at this repository.
2. Netlify reads `netlify.toml`; the publish folder is `site`. There is no build step.
3. After the first deploy, open Forms in the Netlify dashboard and turn on email notifications for the `waitlist` form.
4. Add your domain under Domain management.

## What learners use

The course is written to be tool-agnostic. Each learner needs:

- One AI chat assistant (Claude, ChatGPT or Gemini; free tiers are enough to start)
- One simple page builder (Canva, Carrd or Google Sites)
- One booking tool (Calendly or similar)
- One way to be paid (a payment link or an invoice)

Module 0 walks them through choosing and opening each one.
