import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["img", "initials", "removeField", "removeBtn", "label", "fileInput"]

  remove() {
    this.removeFieldTarget.value = "1"
    if (this.hasImgTarget) this.imgTarget.style.display = "none"
    this.initialsTarget.style.display = "flex"
    this.fileInputTarget.value = ""
    this.removeBtnTarget.style.display = "none"
    this.labelTarget.textContent = "Ajouter une photo"
  }

  previewFile(event) {
    const file = event.target.files[0]
    if (!file) return

    this.initialsTarget.style.display = "none"
    this.removeFieldTarget.value = "0"

    if (this.hasImgTarget) {
      this.imgTarget.src = URL.createObjectURL(file)
      this.imgTarget.style.display = ""
    } else {
      const img = document.createElement("img")
      img.className = "profile-photo"
      img.dataset.profilePhotoTarget = "img"
      img.alt = "Photo de profil"
      img.src = URL.createObjectURL(file)
      this.initialsTarget.insertAdjacentElement("beforebegin", img)
    }
  }
}
