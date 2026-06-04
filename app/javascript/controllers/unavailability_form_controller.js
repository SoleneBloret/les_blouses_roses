import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["singleTab", "multiTab", "endDateWrapper", "startDate", "endDate"]

  connect() {
    this.showSingle()
  }

  showSingle() {
    this.singleTabTarget.classList.add("active")
    this.multiTabTarget.classList.remove("active")
    this.endDateWrapperTarget.classList.add("d-none")
    this.syncEndDate()
  }

  showMulti() {
    this.multiTabTarget.classList.add("active")
    this.singleTabTarget.classList.remove("active")
    this.endDateWrapperTarget.classList.remove("d-none")
  }

  syncEndDate() {
    if (this.endDateWrapperTarget.classList.contains("d-none")) {
      this.endDateTarget.value = this.startDateTarget.value
    }
  }
}
