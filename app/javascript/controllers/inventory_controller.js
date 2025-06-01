import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "filter"]

  connect() {
    console.log("Inventory controller connected")
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#inventory-items tr")

    rows.forEach(row => {
      const name = row.querySelector("td:first-child").textContent.toLowerCase()
      const category = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (name.includes(searchTerm) || category.includes(searchTerm)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  filter(event) {
    const category = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#inventory-items tr")

    rows.forEach(row => {
      const rowCategory = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (!category || rowCategory.includes(category)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }
} 