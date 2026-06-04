import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value", "input"]

  increment() {
    const current = parseInt(this.valueTarget.textContent)
    const newValue = current + 1
    this.valueTarget.textContent = newValue
    this.inputTarget.value = newValue
  }

  decrement() {
    const current = parseInt(this.valueTarget.textContent)
    if (current <= 0) return
    const newValue = current - 1
    this.valueTarget.textContent = newValue
    this.inputTarget.value = newValue
  }
}
