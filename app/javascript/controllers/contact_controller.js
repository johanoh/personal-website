import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["status"];

  handleSubmitEnd(event) {
    const response = event.detail.fetchResponse;

    if (response.response.status === 429) {
      this.statusTarget.innerHTML = `
        <p class="error">You are submitting messages too quickly. Please wait a moment.</p>
      `;
    }
  }
}
