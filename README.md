[![Build Status](https://travis-ci.org/lyp-packages/assert.svg?branch=master)](https://travis-ci.org/lyp-packages/assert)

# assert: Assertions for Lilypond packages

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


## Testing your package locally

You can use lyp to test your package using the `lyp test` command:

```bash
cd my-package
lyp test .
```

Note that you'll need to install at least one version of lilypond using `lyp install`. For more information on testing see the [lyp documentation](https://github.com/noteflakes/lyp#testing-packages).

## Automatically testing your package using Travis-CI

lyp-assert also serves as an example of how to integrate testing into your build process. To test your package on travis-ci:

- Include a 'Gemfile' in the root directory of your package repository, with the following content:

```ruby
source "http://rubygems.org"
gem "lyp", ">=1.2.0"
```

Then run `bundle install` to install the lyp package and generate the `Gemfile.lock` file. Both `Gemfile` and `Gemfile.lock` should be checked in.

You can also test your package locally by running:

```bash
$ lyp install lilypond@2.18.2 # first install lilypond
$ lyp test .
```

- The `.travis.yml` configures the build process:

```yaml
language: ruby
rvm:
  - 2.2.4

script: bundle exec lyp test . --env --install

cache:
  bundler: true
  directories:
    - $HOME/.lyp
    
env:
  - LILYPOND_VERSION=2.18.2
  - LILYPOND_VERSION=2.19.35

```

The above configuration will automatically test the package on two versions of lilypond (2.18.2 and 2.19.35). You can add or change the lilypond versions by adding or editing `LILYPOND_VERSION` values.

