import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "overlay"]

  open() {
    this.overlayTarget.classList.remove("whatsapp-modal--hidden")
    document.body.style.overflow = "hidden"
  }

  close() {
    this.overlayTarget.classList.add("whatsapp-modal--hidden")
    document.body.style.overflow = ""
  }

  closeOnOverlay(event) {
    if (event.target === this.overlayTarget) {
      this.close()
    }
  }
}
