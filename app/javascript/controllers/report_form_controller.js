import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

const FEELING_EMOJIS  = { "0": "😒", "1": "😐", "2": "🙂", "3": "😄" }
const FEELING_LABELS  = { "0": "Difficile", "1": "Correct", "2": "Bien", "3": "Excellent" }

export default class extends Controller {
  static targets = ["patientsInput"]

  async confirmSubmit(event) {
    if (this.submitting) return
    event.preventDefault()

    const patients = this.patientsInputTarget.value || "0"

    const feelingRadio = this.element.querySelector('input[name*="feeling"]:checked')
    const feelingDisplay = feelingRadio
      ? `${FEELING_EMOJIS[feelingRadio.value]} ${FEELING_LABELS[feelingRadio.value]}`
      : "Non renseigné"

    const result = await Swal.fire({
      title: "Envoyer le compte-rendu ?",
      html: `
        <div style="background:#FDE8F3; border-radius:12px; padding:14px; text-align:left; font-size:14px;">
          <p style="margin:0 0 8px"><strong>👥 Patients visités</strong> : ${patients}</p>
          <p style="margin:0"><strong>✨ Ressenti</strong> : ${feelingDisplay}</p>
        </div>
      `,
      icon: "question",
      showCancelButton: true,
      confirmButtonText: "Envoyer",
      cancelButtonText: "Annuler",
      confirmButtonColor: "#1AAB6D",
      customClass: { popup: "swal-lbr", cancelButton: "swal-btn-outline" },
    })

    if (result.isConfirmed) {
      this.submitting = true
      event.target.closest("form").requestSubmit()
    }
  }
}
