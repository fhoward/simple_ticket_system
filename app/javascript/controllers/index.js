// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
document.addEventListener('turbo:load', () => {
    const ticketStatus = document.getElementById('ticket_status');
    const commentField = document.getElementById('comment_field');
  
    toggleCommentField(ticketStatus.value); // Initial state
  
    ticketStatus.addEventListener('change', (event) => {
      toggleCommentField(event.target.value);
    });
  
    function toggleCommentField(status) {
      if (status === 'resolved' || status === 'Resolved') {
        commentField.classList.remove('d-none');
      } else {
        commentField.classList.add('d-none');
      }
    }
});