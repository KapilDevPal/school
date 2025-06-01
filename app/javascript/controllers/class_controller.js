import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "filter", "form"]

  connect() {
    console.log("Class controller connected")
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#classes tr")

    rows.forEach(row => {
      const name = row.querySelector("td:first-child").textContent.toLowerCase()
      const section = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (name.includes(searchTerm) || section.includes(searchTerm)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  filter(event) {
    const section = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#classes tr")

    rows.forEach(row => {
      const rowSection = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (!section || rowSection.includes(section)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  validateForm(event) {
    const form = event.target
    const name = form.querySelector("#school_class_name").value
    const section = form.querySelector("#school_class_section").value

    if (!name || !section) {
      event.preventDefault()
      alert("Class name and section are required")
    }
  }
} 