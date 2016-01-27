[![Build Status](https://travis-ci.org/noteflakes/lyp-assert.svg?branch=master)](https://travis-ci.org/noteflakes/lyp-assert)

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

```lilypond
% Equality
#(assert:eq? assert assert)
#(assert:eqv? 3 (+ 1 2))
#(assert:equal? (list 1 2 3) (list 1 2 3))

% Comparison
#(assert= 1 1)
#(assert< 1 2)
#(assert> 2 1)
#(assert<= 1 2)
#(assert<= 2 2)
#(assert>= 2 1)
#(assert>= 2 2)

% General comparison
#(assert:compare (list 1 2 3) (list 1 2 3))

% Arbitrary expression
#(assert (string=? "abc" "abc"))

% Assert error thrown
#(assert:throw (lambda () (/ 1 0)))

% Display number of assertions passed at end of test
#(assert:summary)
```

## Automatically testing your package using Travis-CI

lyp-assert also serves as an example of how to integrate testing into your build process. You can simply copy `.travis.yml`, `Gemfile` and `Gemfile.lock` to your package, perform the necessary travis-ci configuration, and your package will be tested each time you push to github.