import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  flashMessageClose(e) {
    e?.preventDefault();
    this.element.remove();
  }
}
