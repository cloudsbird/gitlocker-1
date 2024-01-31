import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

export { application }
