function stripe() {
  const form = document.getElementById("payment_form")
  const stripe = Stripe()
}

window.addEventListener("turbo:load", stripe)
window.addEventListener("turbo:render", stripe)