// Applies the settings in config.js to the page.
(function () {
  var c = window.CONSULT_AIGE || {};
  var selling = typeof c.checkoutUrl === "string" && c.checkoutUrl.trim() !== "";

  function each(selector, fn) {
    Array.prototype.forEach.call(document.querySelectorAll(selector), fn);
  }

  each("[data-price]", function (el) { if (c.price) el.textContent = c.price; });
  each("[data-seats]", function (el) { if (c.seats) el.textContent = c.seats; });

  each("[data-cohort-start]", function (el) {
    if (c.cohortStart) {
      el.textContent = "The next cohort starts " + c.cohortStart + ".";
      el.hidden = false;
    }
  });

  if (selling) {
    each("[data-cta]", function (el) {
      el.setAttribute("href", c.checkoutUrl);
      el.textContent = "Join the Founding Cohort";
    });
    each("[data-waitlist-only]", function (el) { el.hidden = true; });
    each("[data-sales-only]", function (el) { el.hidden = false; });
  }
})();
