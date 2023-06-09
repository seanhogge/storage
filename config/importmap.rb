# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.1.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tailwindcss-stimulus-components" # @3.0.4
pin "stimulus-password-visibility", to: "https://ga.jspm.io/npm:stimulus-password-visibility@2.0.0/dist/stimulus-password-visibility.es.js"
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.2.0/js/all.js"
pin "tom-select", to: "https://ga.jspm.io/npm:tom-select@2.2.2/dist/js/tom-select.complete.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "swiper/element/bundle", to: "https://ga.jspm.io/npm:swiper@9.3.1/element/swiper-element-bundle.js"
pin "ssr-window", to: "https://ga.jspm.io/npm:ssr-window@4.0.2/ssr-window.esm.js"
pin "swiper/bundle", to: "https://ga.jspm.io/npm:swiper@9.3.1/swiper-bundle.esm.js"
