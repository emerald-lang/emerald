<img src='emerald-logo.png' alt='Drawing' width='600px' />
- A language agnostic templating engine designed with event driven applications in mind.

# Usage
```
gem install emerald-lang
emerald process some_html_file --beautify
```

# Contributing
## Setup
```
bundle install
bundle exec rake setup
```

## Running tests
```
bundle exec rake test
```

## Pushing to Rubygems
Update the `EMERALD_VERSION` constant, then:

```
rake release
```
