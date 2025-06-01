import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "filter", "form"]

  connect() {
    console.log("Subject controller connected")
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#subjects tr")

    rows.forEach(row => {
      const name = row.querySelector("td:first-child").textContent.toLowerCase()
      const code = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (name.includes(searchTerm) || code.includes(searchTerm)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  filter(event) {
    const class_name = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#subjects tr")

    rows.forEach(row => {
      const rowClass = row.querySelector("td:nth-child(3)").textContent.toLowerCase()
      
      if (!class_name || rowClass.includes(class_name)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  validateForm(event) {
    const form = event.target
    const name = form.querySelector("#subject_name").value
    const code = form.querySelector("#subject_code").value

    if (!name || !code) {
      event.preventDefault()
      alert("Subject name and code are required")
    }
  }
} 