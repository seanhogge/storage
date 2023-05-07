import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
  }

  goto() {
    console.log(this.urlValue)
    window.location = this.urlValue
  }
}
