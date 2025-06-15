// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application.js"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Register the dropdown controller explicitly
import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)
