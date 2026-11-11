# Consult AI-ge

*Said "consult-age".* A six-week course that teaches retired professionals to use simple AI tools to turn decades of experience into an advisory offer (a checklist, a web page and a first paid call) that younger professionals can find, trust and pay for.

**To launch, open [START-HERE.md](START-HERE.md).** It is a step-by-step runbook; everything it refers to is already in this repository.

## What is here

| Folder | Contents |
|---|---|
| [`plan/`](plan/) | The project brief, the decisions taken on its open questions, pricing, tech stack and legal templates |
| [`course/`](course/) | The full course: seven modules, worksheets, prompt library, worked case study, facilitator guide |
| [`site/`](site/) | The website: landing page, waitlist form, free guide, privacy and terms. Static files, no build step |
| [`marketing/`](marketing/) | Six-week launch plan, email sequences, outreach scripts and posts, info-session script |
| [`brand/`](brand/) | Name, tagline, colours, type and voice |

## Preview the website

```
cd site
python3 -m http.server 8000
```

Then open http://localhost:8000. To open sales, paste a payment link into `site/config.js`.

## Phase 2: the marketplace (parked)

This repository began as a plan for a two-sided marketplace connecting retired experts with tech professionals. That idea is parked until the course has produced enough graduates to supply it; see decision 3 in [`plan/02-decisions.md`](plan/02-decisions.md).

The earlier material is kept unchanged: `docs/`, `bubble-app/`, `scripts/`, the `.github/` weekly audit, and the root-level `AUDIT-*`, `WEEK-*`, `CHECKLIST.md`, `MILESTONE-*` and related files. None of it is needed to launch the course.
