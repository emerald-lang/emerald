// Emerald Language

doc html

html
  head
    link rel="stylesheet", href="css/main.css"
    script src="js/script"

  body
    header
      h1 Emerald
      h2 An html5 markup language designed with scope in mind.

    main
      p Click me!
      button
      *
        border 1px solid #000
      $
        click
          log "I was clicked!"
        end

    footer
      Still in the works!
