// app/javascript/controllers/page_builder_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["canvas", "library", "properties"]

  connect() {
    this.draggedElement = null
    this.draggedComponent = null
    this.dragOverElement = null
    console.log("Page builder connected")
  }

  handleDragStart(event) {
    event.dataTransfer.effectAllowed = 'move'
    event.dataTransfer.setData('text/html', event.target.innerHTML)

    if (event.target.dataset.componentId) {
      // Dragging from library
      this.draggedComponent = event.target.dataset.componentId
      this.draggedElement = null
    } else if (event.target.closest('.page-component')) {
      // Dragging existing component
      this.draggedElement = event.target.closest('.page-component')
      this.draggedComponent = null
    }

    event.target.classList.add('dragging')
  }

  handleDragEnd(event) {
    event.target.classList.remove('dragging')
    // Remove any drop indicators
    document.querySelectorAll('.drop-indicator').forEach(el => el.remove())
    this.draggedElement = null
    this.draggedComponent = null
    this.dragOverElement = null
  }

  handleDragOver(event) {
    if (event.preventDefault) {
      event.preventDefault()
    }

    event.dataTransfer.dropEffect = 'move'

    // Find the element being dragged over
    const afterElement = this.getDragAfterElement(this.canvasTarget, event.clientY)

    // Remove existing drop indicators
    document.querySelectorAll('.drop-indicator').forEach(el => el.remove())

    // Add drop indicator
    const indicator = document.createElement('div')
    indicator.className = 'drop-indicator active'

    if (afterElement == null) {
      this.canvasTarget.appendChild(indicator)
    } else {
      this.canvasTarget.insertBefore(indicator, afterElement)
    }

    return false
  }

  handleDrop(event) {
    if (event.stopPropagation) {
      event.stopPropagation()
    }

    // Remove drop indicators
    document.querySelectorAll('.drop-indicator').forEach(el => el.remove())

    const position = this.getDropPosition(event)

    if (this.draggedComponent) {
      // Adding new component from library
      fetch(`/pages/${this.getPageSlug()}/page_components`, {
        method: 'POST',
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Content-Type': 'application/json',
          'Accept': 'text/vnd.turbo-stream.html'
        },
        body: JSON.stringify({
          component_id: this.draggedComponent,
          position: position
        })
      })
    } else if (this.draggedElement) {
      // Reordering existing component
      const componentId = this.draggedElement.dataset.pageComponentId

      fetch(`/pages/${this.getPageSlug()}/page_components/${componentId}/move`, {
        method: 'PATCH',
        headers: {
          'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ position: position })
      }).then(() => {
        // Reorder DOM elements
        this.reorderComponents(position)
      })
    }

    return false
  }

  selectComponent(event) {
    console.log("Component clicked", event.currentTarget)

    // Don't select if clicking on remove button
    if (event.target.closest('.btn-remove')) {
      return
    }

    const component = event.currentTarget.closest('.page-component')
    const componentId = component.dataset.pageComponentId

    console.log("Component ID:", componentId)

    // Remove previous selection
    document.querySelectorAll('.page-component.selected').forEach(el => {
      el.classList.remove('selected')
    })

    // Add selection to current component
    component.classList.add('selected')

    // Clear the empty state
    const emptyState = document.querySelector('.empty-properties')
    if (emptyState) {
      emptyState.style.display = 'none'
    }

    // Show loading state
    const propertiesContainer = document.getElementById('component-properties')
    propertiesContainer.innerHTML = '<div class="loading-properties"><div class="spinner"></div><p>Loading properties...</p></div>'

    // Load properties panel
    fetch(`/pages/${this.getPageSlug()}/page_components/${componentId}/properties`, {
      headers: {
        'Accept': 'text/html',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      }
    })
    .then(response => {
      if (!response.ok) throw new Error('Failed to load properties')
      return response.text()
    })
    .then(html => {
      propertiesContainer.innerHTML = html
    })
    .catch(error => {
      console.error('Error loading properties:', error)
      propertiesContainer.innerHTML = '<div class="error-message">Failed to load properties. Please try again.</div>'
    })
  }

  getDragAfterElement(container, y) {
    const draggableElements = [...container.querySelectorAll('.page-component:not(.dragging)')]

    return draggableElements.reduce((closest, child) => {
      const box = child.getBoundingClientRect()
      const offset = y - box.top - box.height / 2

      if (offset < 0 && offset > closest.offset) {
        return { offset: offset, element: child }
      } else {
        return closest
      }
    }, { offset: Number.NEGATIVE_INFINITY }).element
  }

  getDropPosition(event) {
    const components = [...this.canvasTarget.querySelectorAll('.page-component:not(.dragging)')]
    const y = event.clientY

    let position = 1
    for (let i = 0; i < components.length; i++) {
      const box = components[i].getBoundingClientRect()
      if (y > box.top + box.height / 2) {
        position = parseInt(components[i].dataset.position) + 1
      } else {
        break
      }
    }

    return position
  }

  reorderComponents(newPosition) {
    const dragging = this.draggedElement
    const currentPosition = parseInt(dragging.dataset.position)

    if (currentPosition === newPosition) return

    const components = [...this.canvasTarget.querySelectorAll('.page-component')]
    const sortedComponents = components.sort((a, b) => {
      const aPos = parseInt(a.dataset.position)
      const bPos = parseInt(b.dataset.position)

      // Handle the dragged element
      if (a === dragging) return newPosition - bPos
      if (b === dragging) return aPos - newPosition

      // Adjust positions for other elements
      if (currentPosition < newPosition) {
        // Moving down
        if (aPos > currentPosition && aPos <= newPosition) return aPos - 1 - bPos
        if (bPos > currentPosition && bPos <= newPosition) return aPos - (bPos - 1)
      } else {
        // Moving up
        if (aPos >= newPosition && aPos < currentPosition) return aPos + 1 - bPos
        if (bPos >= newPosition && bPos < currentPosition) return aPos - (bPos + 1)
      }

      return aPos - bPos
    })

    // Clear the container and re-append in order
    this.canvasTarget.innerHTML = ''
    sortedComponents.forEach(comp => {
      this.canvasTarget.appendChild(comp)
    })
  }

  getPageSlug() {
    return window.location.pathname.split('/')[2]
  }

  togglePublished(event) {
    const form = event.target.closest('form')
    form.requestSubmit()
  }
}

// Add loading styles
const style = document.createElement('style')
style.textContent = `
  .loading-properties {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 3rem;
    color: #6b7280;
  }

  .spinner {
    width: 24px;
    height: 24px;
    border: 3px solid #e5e7eb;
    border-top-color: #3b82f6;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
    margin-bottom: 1rem;
  }

  @keyframes spin {
    to { transform: rotate(360deg); }
  }

  .error-message {
    color: #ef4444;
    text-align: center;
    padding: 2rem;
    font-size: 0.875rem;
  }
`
document.head.appendChild(style)