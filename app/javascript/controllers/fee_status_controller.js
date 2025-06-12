import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["paymentFields"]

  connect() {
    this.togglePaymentFields()
  }

  togglePaymentFields() {
    const status = this.element.value
    if (status === 'paid') {
      this.paymentFieldsTarget.classList.remove('hidden')
    } else {
      this.paymentFieldsTarget.classList.add('hidden')
    }
  }
} 