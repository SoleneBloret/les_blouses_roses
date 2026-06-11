import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this._outsideClick = this._handleOutsideClick.bind(this)
    document.addEventListener("click", this._outsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this._outsideClick)
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("header-dropdown-menu--open")
  }

  _handleOutsideClick() {
    this.menuTarget.classList.remove("header-dropdown-menu--open")
  }
}
