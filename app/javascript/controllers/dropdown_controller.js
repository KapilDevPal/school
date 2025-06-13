import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "icon"]
  
  connect() {
    console.log("Dropdown controller connected")
    // Initialize menu state
    this.menuTarget.classList.add(this.menuClass)
  }

  toggle() {
    console.log("Toggle clicked")
    console.log("Menu target:", this.menuTarget)
    console.log("Icon target:", this.iconTarget)
    
    // Toggle menu visibility
    this.menuTarget.classList.toggle(this.menuClass)
    
    // Toggle icon rotation
    this.iconTarget.classList.toggle(this.expandedClass)
  }

  get menuClass() {
    return this.data.get("menuClass") || "hidden"
  }

  get expandedClass() {
    return this.data.get("expandedClass") || "rotate-180"
  }
} 