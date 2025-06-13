import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["stopsList"]

  connect() {
    console.log("Route stops controller connected")
  }

  addStop(event) {
    event.preventDefault()
    const timestamp = new Date().getTime()
    const template = `
      <tr class="stop-row">
        <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
          <input type="text" name="transport_route[route_stops_attributes][${timestamp}][stop_name]" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
          <input type="hidden" name="transport_route[route_stops_attributes][${timestamp}][stop_order]" value="${this.nextStopOrder()}">
        </td>
        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
          <input type="time" name="transport_route[route_stops_attributes][${timestamp}][arrival_time]" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
        </td>
        <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
          <input type="time" name="transport_route[route_stops_attributes][${timestamp}][departure_time]" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
        </td>
        <td class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
          <button type="button" 
                  class="text-red-600 hover:text-red-900"
                  data-action="click->route-stops#removeStop">
            Remove
          </button>
        </td>
      </tr>
    `
    this.stopsListTarget.insertAdjacentHTML('beforeend', template)
  }

  removeStop(event) {
    event.preventDefault()
    const row = event.target.closest('.stop-row')
    if (row) {
      row.remove()
      this.updateStopOrders()
    }
  }

  nextStopOrder() {
    const existingOrders = Array.from(this.stopsListTarget.querySelectorAll('input[name*="[stop_order]"]'))
      .map(input => parseInt(input.value) || 0)
    return Math.max(0, ...existingOrders) + 1
  }

  updateStopOrders() {
    const rows = this.stopsListTarget.querySelectorAll('.stop-row')
    rows.forEach((row, index) => {
      const orderInput = row.querySelector('input[name*="[stop_order]"]')
      if (orderInput) {
        orderInput.value = index + 1
      }
    })
  }
} 