import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

export default class extends Controller {
  static values = {
    location: String,
    date: String,
    time: String,
    availablePath: String
  }

  async confirmEngage(event) {
    event.preventDefault()

    const result = await Swal.fire({
      title: "Je m'engage",
      html: `
        <p style="margin-bottom: 8px;">Tu t'apprêtes à prendre cette permanence :</p>
        <div style="background:#FDE8F3; border-radius:12px; padding:14px; text-align:left; font-size:14px;">
          <p style="margin:0 0 6px"><strong>📍 Lieu</strong> : ${this.locationValue}</p>
          <p style="margin:0 0 6px"><strong>📅 Date</strong> : ${this.dateValue}</p>
          <p style="margin:0"><strong>🕐 Horaires</strong> : ${this.timeValue}</p>
        </div>
        <p style="margin-top:12px; font-size:13px; color:#9B7FA0;">Tu retrouveras cette permanence dans ton agenda.</p>
      `,
      icon: "question",
      showCancelButton: true,
      confirmButtonText: "Je confirme",
      cancelButtonText: "Annuler",
      confirmButtonColor: "#1AAB6D",
      customClass: { cancelButton: "swal-btn-outline" },
    })

    if (result.isConfirmed) {
      event.target.closest("form").submit()
    }
  }

  async confirmUnavailable(event) {
    event.preventDefault()

    const result = await Swal.fire({
      title: "Pas disponible",
      html: `
        <p style="margin-bottom: 8px;">Cette permanence n'apparaîtra plus dans la liste des permanences disponibles.</p>
        <div style="background:#FFF8F5; border:1.5px solid rgba(229,0,125,0.2); border-radius:12px; padding:14px; text-align:left; font-size:14px;">
          <p style="margin:0 0 6px"><strong>📍 Lieu</strong> : ${this.locationValue}</p>
          <p style="margin:0 0 6px"><strong>📅 Date</strong> : ${this.dateValue}</p>
          <p style="margin:0"><strong>🕐 Horaires</strong> : ${this.timeValue}</p>
        </div>
      `,
      icon: "info",
      showCancelButton: true,
      confirmButtonText: "OK",
      cancelButtonText: "Retour",
      confirmButtonColor: "#E5007D",
      customClass: { cancelButton: "swal-btn-outline" },
    })

    if (result.isConfirmed) {
      window.location.href = this.availablePathValue
    }
  }
}
