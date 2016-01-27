[![Build Status](https://travis-ci.org/noteflakes/lyp-assert.svg?branch=master)](https://travis-ci.org/noteflakes/assert-lyp)

# lyp-assert - assertions for lilypond packages

This package provides assert functionality for [lyp](https://github.com/noteflakes/lyp) packages, in order to facilitate unit-testing lilypond and scheme code.

## Installation

```bash
lyp install assert
```

## Usage

```lilypond
\require "assert"

#(assert (eq? 1 1))
```

lyp-assert provides multiple scheme functions to do assertions:

```scheme
(assert expr)
(assert-eq? x y)
(assert-eqv? x y)
(assert-equal? x y)
(assert> x y)
(assert< x y)
(assert>= x y)
(assert<= x y)
```

## Automatically testing your package using Travis-CI

lyp-assert also serves as an example of how to integrate testing into your build process. You can simply copy `.travis.yml`, `Gemfile` and `Gemfile.lock` to your package, perform the necessary travis-ci configuration, and your package will be tested each time you push to github.