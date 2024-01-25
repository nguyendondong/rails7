import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autohide"
export default class extends Controller {
  static  targets = ["autoHideContent"]
  connect() {
  }

  hideButton(){
    this.autoHideContentTarget.hidden = true;
  }

}
