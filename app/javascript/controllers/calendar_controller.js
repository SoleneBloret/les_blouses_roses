import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["grid", "title", "card"]
  static values = { dates: Array }

  connect() {
    this.today = new Date()
    this.current = new Date(this.today.getFullYear(), this.today.getMonth(), 1)
    this.selectedDate = null
    this.render()
  }

  prev() {
    this.current = new Date(this.current.getFullYear(), this.current.getMonth() - 1, 1)
    this.selectedDate = null
    this.filterCards()
    this.render()
  }

  next() {
    this.current = new Date(this.current.getFullYear(), this.current.getMonth() + 1, 1)
    this.selectedDate = null
    this.filterCards()
    this.render()
  }

  selectDay(event) {
    const date = event.currentTarget.dataset.date
    this.selectedDate = this.selectedDate === date ? null : date
    this.filterCards()
    this.render()
  }

  render() {
    const year = this.current.getFullYear()
    const month = this.current.getMonth()

    const monthName = new Intl.DateTimeFormat("fr-FR", { month: "long", year: "numeric" }).format(this.current)
    this.titleTarget.textContent = monthName.charAt(0).toUpperCase() + monthName.slice(1)

    const participationDates = new Set(this.datesValue.map(d => d.date))
    const todayStr = this.isoDate(this.today)

    // ISO week starts Monday: JS getDay() is 0=Sun, so shift
    const firstDow = (new Date(year, month, 1).getDay() + 6) % 7
    const daysInMonth = new Date(year, month + 1, 0).getDate()

    let html = ""

    for (let i = 0; i < firstDow; i++) {
      html += `<div class="cal-day cal-day--empty"></div>`
    }

    for (let day = 1; day <= daysInMonth; day++) {
      const dateStr = this.isoDate(new Date(year, month, day))
      const dow = new Date(year, month, day).getDay()
      const isToday = dateStr === todayStr
      const hasEvent = participationDates.has(dateStr)
      const isSelected = dateStr === this.selectedDate
      const isWeekend = dow === 0 || dow === 6

      const classes = ["cal-day"]
      if (isToday) classes.push("cal-day--today")
      if (isSelected && !isToday) classes.push("cal-day--selected")
      if (isWeekend) classes.push("cal-day--weekend")
      if (hasEvent) classes.push("cal-day--has-event")

      const action = hasEvent ? `data-action="click->calendar#selectDay" data-date="${dateStr}"` : ""

      html += `<div class="${classes.join(" ")}" ${action}>`
      html += `<span class="cal-day__num">${day}</span>`
      if (hasEvent) html += `<span class="cal-day__dot"></span>`
      html += `</div>`
    }

    this.gridTarget.innerHTML = html
  }

  filterCards() {
    this.cardTargets.forEach(card => {
      const show = !this.selectedDate || card.dataset.participationDate === this.selectedDate
      card.style.display = show ? "" : "none"
    })
  }

  isoDate(date) {
    const y = date.getFullYear()
    const m = String(date.getMonth() + 1).padStart(2, "0")
    const d = String(date.getDate()).padStart(2, "0")
    return `${y}-${m}-${d}`
  }
}
