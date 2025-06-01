import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "filter", "date", "form"]

  connect() {
    console.log("Attendance controller connected")
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#attendance-records tr")

    rows.forEach(row => {
      const name = row.querySelector("td:first-child").textContent.toLowerCase()
      const status = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (name.includes(searchTerm) || status.includes(searchTerm)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  filter(event) {
    const status = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#attendance-records tr")

    rows.forEach(row => {
      const rowStatus = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (!status || rowStatus.includes(status)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  setToday() {
    const today = new Date().toISOString().split('T')[0]
    this.dateTarget.value = today
  }

  validateForm(event) {
    const form = event.target
    const date = form.querySelector("#attendance_record_date").value
    const today = new Date().toISOString().split('T')[0]

    if (date > today) {
      event.preventDefault()
      alert("Cannot mark attendance for future dates")
    }
  }
} 