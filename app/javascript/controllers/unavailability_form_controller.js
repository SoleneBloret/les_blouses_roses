import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

export default class extends Controller {
  static targets = ["singleTab", "multiTab", "endDateWrapper", "startDate", "endDate"]

  connect() {
    this.showSingle()
  }

  showSingle() {
    this.singleTabTarget.classList.add("active")
    this.singleTabTarget.setAttribute("aria-pressed", "true")
    this.multiTabTarget.classList.remove("active")
    this.multiTabTarget.setAttribute("aria-pressed", "false")
    this.endDateWrapperTarget.classList.add("d-none")
    this.syncEndDate()
  }

  showMulti() {
    this.multiTabTarget.classList.add("active")
    this.multiTabTarget.setAttribute("aria-pressed", "true")
    this.singleTabTarget.classList.remove("active")
    this.singleTabTarget.setAttribute("aria-pressed", "false")
    this.endDateWrapperTarget.classList.remove("d-none")
  }

  syncEndDate() {
    if (this.endDateWrapperTarget.classList.contains("d-none")) {
      this.endDateTarget.value = this.startDateTarget.value
    }
  }

  async confirmSubmit(event) {
    if (this.submitting) return
    event.preventDefault()

    if (!this.startDateTarget.value) {
      await Swal.fire({
        title: "Date manquante",
        text: "Veuillez sélectionner une date avant de confirmer votre absence.",
        icon: "error",
        confirmButtonText: "OK",
        confirmButtonColor: "#E5007D",
      })
      return
    }

    const result = await Swal.fire({
      title: "Confirmer votre absence ?",
      text: "Votre indisponibilité sera enregistrée et vos permanences concernées seront libérées.",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Confirmer",
      cancelButtonText: "Annuler",
      confirmButtonColor: "#1AAB6D",
      customClass: { cancelButton: "swal-btn-outline" },
    })

    if (result.isConfirmed) {
      this.submitting = true
      event.target.requestSubmit()
    }
  }
}
