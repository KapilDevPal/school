import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "filter", "form"]

  connect() {
    console.log("Fee controller connected")
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#fees tr")

    rows.forEach(row => {
      const name = row.querySelector("td:first-child").textContent.toLowerCase()
      const type = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (name.includes(searchTerm) || type.includes(searchTerm)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  filter(event) {
    const type = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#fees tr")

    rows.forEach(row => {
      const rowType = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (!type || rowType.includes(type)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  validateForm(event) {
    const form = event.target
    const amount = parseFloat(form.querySelector("#fee_amount").value)
    const dueDate = form.querySelector("#fee_due_date").value

    if (isNaN(amount) || amount <= 0) {
      event.preventDefault()
      alert("Amount must be greater than 0")
    }

    if (!dueDate) {
      event.preventDefault()
      alert("Due date is required")
    }
  }
} 