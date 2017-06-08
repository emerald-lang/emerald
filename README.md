<p align="center">
  <img src='emerald-logo.png' alt='Drawing' width='600px' />
</p>

![Emerald Language](https://raw.githubusercontent.com/emerald-lang/emerald-emacs/master/emerald.png)

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
