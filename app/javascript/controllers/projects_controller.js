import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  toggle(event) {
    const projectId = event.currentTarget.dataset.projectId
    const contentDiv = document.getElementById(`project-${projectId}`)

    if (contentDiv.innerHTML.trim() === "") {
      fetch(`/projects/${projectId}`)
        .then(response => response.text())
        .then(html => {
          contentDiv.innerHTML = html
          contentDiv.style.display = "block"
        })
    } else {
      contentDiv.innerHTML = ""
      contentDiv.style.display = "none"
    }
  }
}
