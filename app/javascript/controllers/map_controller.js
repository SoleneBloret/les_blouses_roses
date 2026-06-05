import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static targets = ["container", "locateBtn"]
  static values = { token: String, latitude: Number, longitude: Number }

  connect() {
    mapboxgl.accessToken = this.tokenValue

    this.map = new mapboxgl.Map({
      container: this.containerTarget,
      style: "mapbox://styles/mapbox/streets-v12",
      center: [this.longitudeValue, this.latitudeValue],
      zoom: 15
    })

    // Pin rose sur le lieu de permanence
    new mapboxgl.Marker({ color: "#E5007D" })
      .setLngLat([this.longitudeValue, this.latitudeValue])
      .addTo(this.map)
  }

  locateUser() {
    if (this.locateBtnTarget.classList.contains("map-action-btn--active")) {
      this.locateBtnTarget.classList.remove("map-action-btn--active")
      this.userMarker?.remove()
      this.userMarker = null
      return
    }

    this.locateBtnTarget.classList.add("map-action-btn--active")

    navigator.geolocation.getCurrentPosition((position) => {
      const { longitude, latitude } = position.coords

      this.map.flyTo({ center: [longitude, latitude], zoom: 15 })

      this.userMarker = new mapboxgl.Marker({ color: "#1FAD9F" })
        .setLngLat([longitude, latitude])
        .addTo(this.map)
    }, () => {
      this.locateBtnTarget.classList.remove("map-action-btn--active")
    })
  }

  disconnect() {
    this.map?.remove()
  }
}
