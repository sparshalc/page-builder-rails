// app/javascript/controllers/component_properties_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.debounceTimer = null
  }

  updatePreview(event) {
    // Clear existing timer
    if (this.debounceTimer) {
      clearTimeout(this.debounceTimer)
    }

    // Debounce updates to avoid too many requests
    this.debounceTimer = setTimeout(() => {
      const form = event.target.closest('form')
      const formData = new FormData(form)

      // Update the component immediately in the DOM for instant feedback
      const selectedComponent = document.querySelector('.page-component.selected')
      if (selectedComponent) {
        const componentContent = selectedComponent.querySelector('.component-content')
        const originalHtml = componentContent.dataset.originalHtml || componentContent.innerHTML

        // Store original HTML if not already stored
        if (!componentContent.dataset.originalHtml) {
          componentContent.dataset.originalHtml = originalHtml
        }

        // Get all custom properties from form
        let updatedHtml = originalHtml
        const customProperties = {}

        for (let [key, value] of formData.entries()) {
          if (key.startsWith('page_component[custom_properties]')) {
            const propertyName = key.match(/\[([^\]]+)\]$/)[1]
            customProperties[propertyName] = value

            // Replace template variables in HTML
            const regex = new RegExp(`{{${propertyName}}}`, 'g')
            updatedHtml = updatedHtml.replace(regex, value)
          }
        }

        // Update the preview
        componentContent.innerHTML = updatedHtml
      }

      // Auto-save after a delay
      this.autoSave(form)
    }, 300)
  }

  updateColor(event) {
    // Update the text field when color picker changes
    const colorValue = event.target.value
    const textField = event.target.closest('.color-field').querySelector('.form-control')
    textField.value = colorValue

    // Trigger preview update
    this.updatePreview(event)
  }

  autoSave(form) {
    // Clear any existing auto-save timer
    if (this.autoSaveTimer) {
      clearTimeout(this.autoSaveTimer)
    }

    // Auto-save after 1 second of no changes
    this.autoSaveTimer = setTimeout(() => {
      fetch(form.action, {
        method: form.method,
        body: new FormData(form),
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Accept': 'application/json'
        }
      })
      .then(response => response.json())
      .then(data => {
        // Show save indicator
        this.showSaveIndicator()
      })
      .catch(error => {
        console.error('Auto-save failed:', error)
      })
    }, 1000)
  }

  showSaveIndicator() {
    // Add a visual indicator that changes were saved
    const form = this.element.querySelector('form')
    const indicator = document.createElement('div')
    indicator.className = 'save-indicator'
    indicator.textContent = 'Saved'

    form.appendChild(indicator)

    setTimeout(() => {
      indicator.remove()
    }, 2000)
  }

  disconnect() {
    if (this.debounceTimer) {
      clearTimeout(this.debounceTimer)
    }
    if (this.autoSaveTimer) {
      clearTimeout(this.autoSaveTimer)
    }
  }
}

// Add styles for save indicator
const style = document.createElement('style')
style.textContent = `
  .save-indicator {
    position: absolute;
    top: 1rem;
    right: 1rem;
    background: #10b981;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    font-weight: 500;
    animation: fadeIn 0.3s ease-out;
  }

  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(-10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
`
document.head.appendChild(style)