import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "label"]
  static values = { successLabel: { type: String, default: "Copied" }, resetDelay: { type: Number, default: 1800 } }

  async copy() {
    const text = this.sourceTarget.textContent.trim()

    try {
      await navigator.clipboard.writeText(text)
    } catch {
      // Clipboard API is unavailable over plain HTTP on some browsers
      const field = document.createElement("textarea")
      field.value = text
      field.setAttribute("readonly", "")
      field.style.position = "fixed"
      field.style.opacity = "0"
      document.body.appendChild(field)
      field.select()
      document.execCommand("copy")
      field.remove()
    }

    this.flash()
  }

  flash() {
    if (!this.hasLabelTarget) return

    const original = this.labelTarget.textContent
    this.labelTarget.textContent = this.successLabelValue
    clearTimeout(this.resetTimeout)
    this.resetTimeout = setTimeout(() => {
      this.labelTarget.textContent = original
    }, this.resetDelayValue)
  }

  disconnect() {
    clearTimeout(this.resetTimeout)
  }
}
