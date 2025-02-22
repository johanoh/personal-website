// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "dark_mode";
import "jquery";  // Import jQuery first
import "select2";  // Import the Select2 JavaScript

document.addEventListener("DOMContentLoaded", () => {
    // Initialize Select2 on the .tag-select element
    $(".tag-select").select2({
      placeholder: "Search or select tags",
      allowClear: true
    });
  });
  