// app/javascript/controllers/image_upload_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview", "url"]

  upload(event) {
    const file = event.target.files[0]
    if (!file) return

    // Show preview immediately
    const reader = new FileReader()
    reader.onload = (e) => {
      if (this.hasPreviewTarget) {
        this.previewTarget.src = e.target.result
        this.previewTarget.classList.remove('hidden')
      }
    }
    reader.readAsDataURL(file)

    // Upload file
    const formData = new FormData()
    formData.append('file', file)

    fetch('/image_uploads', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      body: formData
    })
    .then(response => {
      if (!response.ok) throw new Error('Upload failed')
      return response.json()
    })
    .then(data => {
      this.urlTarget.value = data.url

      if (this.hasPreviewTarget) {
        this.previewTarget.src = data.url
        this.previewTarget.classList.remove('hidden')
      }

      // Trigger change event for other controllers
      const event = new Event('change', { bubbles: true })
      this.urlTarget.dispatchEvent(event)
    })
    .catch(error => {
      console.error('Upload error:', error)
      alert('Failed to upload image. Please try again.')
    })
  }
}