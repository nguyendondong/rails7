import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autohide"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.hide()
    }, 2000);
  }

  hide(){
    this.element.remove()
  }

}
