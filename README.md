<img src='emerald-logo.png' alt='Drawing' width='600px' />
- A language agnostic templating engine designed with event driven applications in mind.

# Setup
```
bundle install
bundle exec rake setup
```

# Running tests
```
bundle exec rake test
```


# Todo:
### General
- [x] Design final logo

### Emerald
#### Design
- [x] Add 'thor' gem for making a command line interface.
- [ ] Add component like feature, which lets user define their own component keywords, and the data they expect to pass in. Have an option to specify default parameters for components.

#### Github
- [x] Add continuous integration which runs unit tests to ensure nothing breaks when a new pull request is made.
- [ ] Add rubocop check to determine lint errors and have a threshold of compliancy. Reject builds that do not meet this threshold.

#### Testing
- [ ] Add unit tests and code coverage tool to ensure a suitable threshold of coverage.

#### Templating
- [ ] Add keywords for conditional logic `if, else, etc.`
- [ ] Add keywords for iteration `for, while, etc.`

### Website
- [ ] Make website with Emerald templating engine, and Ruby (with sinatra) backend.

### Syntax highlighting
- [ ] make Vim syntax highlighter
- [ ] make Emacs syntax highlighter
- [ ] make Atom syntax highlighter
- [ ] make Sublime syntax highlighter

### Docs
- [ ] Make documentation for Emerald version 0.0.
