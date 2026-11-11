// Consult AI-ge site settings. This is the only file you need to edit
// to go from test launch to real launch, and to open or close sales.
//
// testMode     true  = test launch. Shows a "test version" banner on every
//                      page and asks search engines not to list the site.
//              false = real launch. Set this only after filling in
//                      "business" below with real details.
// checkoutUrl  Leave empty ("") to collect a waitlist. Paste a payment
//              link (for example a Stripe Payment Link) to open sales:
//              every button on the page will then lead to checkout.
// price        Shown on the page.
// cohortStart  For example "Monday 11 January". Leave empty to hide it.
// seats        Number of places in the cohort.
// business     Shown on the Privacy and Terms pages.
window.CONSULT_AIGE = {
  testMode: true,
  checkoutUrl: "",
  price: "$297",
  cohortStart: "",
  seats: 12,
  business: {
    legalName: "Consult AI-ge (test)",
    location: "location to be confirmed",
    email: "hello@example.com",
    providers: "a website host, an email tool and a payment provider",
    updated: "to be confirmed"
  }
};
