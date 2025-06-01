import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "filter", "form"]

  connect() {
    console.log("Notice controller connected")
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#notices tr")

    rows.forEach(row => {
      const title = row.querySelector("td:first-child").textContent.toLowerCase()
      const category = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (title.includes(searchTerm) || category.includes(searchTerm)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  filter(event) {
    const category = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#notices tr")

    rows.forEach(row => {
      const rowCategory = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (!category || rowCategory.includes(category)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  validateForm(event) {
    const form = event.target
    const title = form.querySelector("#notice_title").value
    const content = form.querySelector("#notice_content").value

    if (!title || !content) {
      event.preventDefault()
      alert("Title and content are required")
    }
  }
} 