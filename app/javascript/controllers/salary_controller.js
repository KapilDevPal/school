import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["search", "filter", "form"]

  connect() {
    console.log("Salary controller connected")
  }

  search(event) {
    const searchTerm = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#salary-structures tr")

    rows.forEach(row => {
      const name = row.querySelector("td:first-child").textContent.toLowerCase()
      const department = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (name.includes(searchTerm) || department.includes(searchTerm)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  filter(event) {
    const department = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#salary-structures tr")

    rows.forEach(row => {
      const rowDepartment = row.querySelector("td:nth-child(2)").textContent.toLowerCase()
      
      if (!department || rowDepartment.includes(department)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }

  validateForm(event) {
    const form = event.target
    const basicSalary = parseFloat(form.querySelector("#salary_structure_basic_salary").value)
    const allowances = parseFloat(form.querySelector("#salary_structure_allowances").value)
    const deductions = parseFloat(form.querySelector("#salary_structure_deductions").value)

    if (basicSalary < 0 || allowances < 0 || deductions < 0) {
      event.preventDefault()
      alert("Values cannot be negative")
    }
  }
} 