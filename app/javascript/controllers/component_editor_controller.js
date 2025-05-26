// app/javascript/controllers/component_editor_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["htmlEditor", "preview", "properties"]

  connect() {
    this.updatePreview()
  }

  updatePreview() {
    const html = this.htmlEditorTarget.value
    const properties = this.getProperties()

    let renderedHtml = html
    Object.entries(properties).forEach(([key, value]) => {
      renderedHtml = renderedHtml.replace(new RegExp(`{{${key}}}`, 'g'), value)
    })

    this.previewTarget.innerHTML = renderedHtml
  }

  addProperty() {
    const propertyIndex = this.propertiesTarget.children.length
    const propertyHtml = `
      <div class="property-field">
        <input type="text"
               name="component[properties][key_${propertyIndex}]"
               placeholder="Property name"
               class="form-control form-control-sm"
               data-action="input->component-editor#updatePreview">
        <input type="text"
               name="component[properties][value_${propertyIndex}]"
               placeholder="Default value"
               class="form-control form-control-sm"
               data-action="input->component-editor#updatePreview">
        <button type="button"
                class="btn btn-sm btn-danger"
                data-action="click->component-editor#removeProperty">
          Remove
        </button>
      </div>
    `

    this.propertiesTarget.insertAdjacentHTML('beforeend', propertyHtml)
  }

  removeProperty(event) {
    event.target.closest('.property-field').remove()
    this.updatePreview()
  }

  getProperties() {
    const properties = {}
    const fields = this.propertiesTarget.querySelectorAll('.property-field')

    fields.forEach(field => {
      const key = field.querySelector('[placeholder="Property name"]').value
      const value = field.querySelector('[placeholder="Default value"]').value
      if (key) {
        properties[key] = value
      }
    })

    return properties
  }
}
