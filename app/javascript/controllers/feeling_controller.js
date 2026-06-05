import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]

  select(event) {
    this.cardTargets.forEach(card => card.classList.remove("feeling-card--selected"))
    const label = this.element.querySelector(`label[for="${event.target.id}"]`)
    if (label) label.classList.add("feeling-card--selected")
  }
}
