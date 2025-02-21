# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "easymde", to: "https://esm.sh/easymde"
pin "select2", to: "https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
