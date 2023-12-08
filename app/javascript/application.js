// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//= require rails-ujs

import "popper"
import "bootstrap"

document.addEventListener('turbo:load', () => {
    const ticketStatus = document.getElementById('ticket_status');
    const commentField = document.getElementById('comment_field');
  
    toggleCommentField(ticketStatus.value); // Initial state
  
    ticketStatus.addEventListener('change', (event) => {
      toggleCommentField(event.target.value);
    });
  
    function toggleCommentField(status) {
      if (status.toLowerCase() === 'resolved') {
        commentField.classList.remove('d-none');
      } else {
        commentField.classList.add('d-none');
      }
    }
  });