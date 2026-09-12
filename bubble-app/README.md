# Bubble App Setup Guide

## Pre-Build Setup

### Create Bubble Workspace
1. Go to https://bubble.io
2. Create account (if not exists)
3. Create new app: `consult-ai-ge`
4. Set to **Production** environment
5. Enable Git-like versioning

### Plugins to Install
1. **Stripe Connector** — For payments
2. **Bubble Messenger** — For messaging (optional)
3. **SendGrid** — For advanced email (optional)

## Week 1: Database Schema

Create these 8 tables:
- Users
- Consultants
- Clients
- Matches
- Bookings
- Messages
- Reviews
- Subscriptions

See docs/06-TECHNICAL-ARCHITECTURE.md for full schema.

## Pages to Create

1. index (homepage)
2. signup-consultant
3. signup-client
4. profile-consultant
5. profile-client
6. dashboard-consultant
7. dashboard-client
8. consultant-detail
9. messages
10. admin-dashboard (Bolivar only)

## Workflows

Create authentication, matching, messaging, payment, and rating workflows.

See implementation roadmap for detailed tasks.

**Setup Date:** 2026-09-12
**Status:** Ready for Week 1 build
