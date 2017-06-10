<p align="center">
  <img src='emerald-logo.png' alt='Drawing' width='600px' />
  <br>
  <i>One templating language, for any stack.</i>
  <p align="center">
  <a href="https://circleci.com/gh/emerald-lang/">
    <img src="https://circleci.com/gh/emerald-lang/emerald.svg?style=shield" alt="Build Status">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License">
  </a>
</p>
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
