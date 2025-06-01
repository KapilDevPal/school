import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "filter", "form"]

  connect() {
    console.log("Student controller connected")
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#students tr")

    rows.forEach(row => {
      const name = row.querySelector("td:first-child").textContent.toLowerCase()
      const class_name = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (name.includes(searchTerm) || class_name.includes(searchTerm)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  filter(event) {
    const class_name = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#students tr")

    rows.forEach(row => {
      const rowClass = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (!class_name || rowClass.includes(class_name)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  validateForm(event) {
    const form = event.target
    const admissionNumber = form.querySelector("#student_admission_number").value
    const email = form.querySelector("#student_email").value

    if (!admissionNumber || !email) {
      event.preventDefault()
      alert("Admission number and email are required")
    }
  }
} 