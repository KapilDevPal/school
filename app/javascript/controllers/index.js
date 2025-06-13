// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Register the dropdown controller explicitly
import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)
