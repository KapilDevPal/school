import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    // Add event listener for escape key
    document.addEventListener('keydown', this.handleKeyDown.bind(this))
  }

  disconnect() {
    // Remove event listener when controller is disconnected
    document.removeEventListener('keydown', this.handleKeyDown.bind(this))
  }

  open(event) {
    event.preventDefault()
    const modalId = event.currentTarget.dataset.modalTarget
    const modal = document.getElementById(modalId)
    if (modal) {
      modal.classList.remove('hidden')
      document.body.style.overflow = 'hidden'
    }
  }

  close(event) {
    event.preventDefault()
    const modal = event.currentTarget.closest('[data-modal-target]')
    if (modal) {
      modal.classList.add('hidden')
      document.body.style.overflow = ''
    }
  }

  handleKeyDown(event) {
    if (event.key === 'Escape') {
      const visibleModal = document.querySelector('[data-modal-target]:not(.hidden)')
      if (visibleModal) {
        visibleModal.classList.add('hidden')
        document.body.style.overflow = ''
      }
    }
  }
} 