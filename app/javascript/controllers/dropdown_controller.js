import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button"]
  
  connect() {
    // Close dropdown when clicking outside
    document.addEventListener("click", this.handleClickOutside.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this))
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }

  get menuClass() {
    return this.data.get("menuClass") || "hidden"
  }

  get expandedClass() {
    return this.data.get("expandedClass") || "rotate-180"
  }
} 