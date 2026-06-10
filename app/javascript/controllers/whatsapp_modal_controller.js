import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "dialog"]

  open(event) {
    this.triggerElement = event.currentTarget
    this.overlayTarget.classList.remove("whatsapp-modal--hidden")
    document.body.style.overflow = "hidden"
    document.addEventListener("keydown", this.handleKeydown)
    this.dialogTarget.focus()
  }

  close() {
    this.overlayTarget.classList.add("whatsapp-modal--hidden")
    document.body.style.overflow = ""
    document.removeEventListener("keydown", this.handleKeydown)
    this.triggerElement?.focus()
  }

  closeOnOverlay(event) {
    if (event.target === this.overlayTarget) {
      this.close()
    }
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown)
  }

  handleKeydown = (event) => {
    if (event.key === "Escape") {
      this.close()
    } else if (event.key === "Tab") {
      this.trapFocus(event)
    }
  }

  trapFocus(event) {
    const focusable = this.dialogTarget.querySelectorAll("a[href], button:not([disabled])")
    const first = focusable[0]
    const last = focusable[focusable.length - 1]

    if (event.shiftKey && document.activeElement === first) {
      event.preventDefault()
      last.focus()
    } else if (!event.shiftKey && document.activeElement === last) {
      event.preventDefault()
      first.focus()
    }
  }
}
