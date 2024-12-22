function flash() {
  const flashMessage = document.getElementById("flash-message")
  if (flashMessage && flashMessage.innerHTML.trim() !== "") {
    flashMessage.classList.add("show")

    setTimeout(function() {
      flashMessage.classList.add("hide")
    }, 5000)
  }
}

window.addEventListener("turbo:load", flash)
window.addEventListener("turbo:render", flash)