function stripe() {
  const form = document.getElementById("payment_form")
  const cardElementField = document.getElementById("card_element_field")
  const publicKey = gon.public_key
  const stripe = Stripe(publicKey)
  const elements = stripe.elements()
  const cardElement = elements.create("card")
  cardElement.mount(cardElementField)

  form.addEventListener("submit", async (e) => {
    e.preventDefault()
    const { paymentMethod, error} = await stripe.createPaymentMethod({
      type: "card",
      card: cardElement,
    })

    if (error) {
      console.error(error)
    } else {
      const formData = new FormData()
      formData.append("payment_method_id", paymentMethod,id)
      fetch("/subscriptions", {
        method: "POST",
        body: formData
      })
    }
  })
}

window.addEventListener("turbo:load", stripe)
window.addEventListener("turbo:render", stripe)