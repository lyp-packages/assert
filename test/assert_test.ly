\version "2.18.2"
\include "../package.ly"

#(define error-caught #f)

% When an assertion fails it throws an error
% Here we catch the error and set the error-caught flag
#(catch #t
  (lambda () (assert-eq? 1 2))
  (lambda (key . parameters)
    (set! error-caught #t)
  )
)

% Use assert to make sure the assert error was caught
#(assert-eq? error-caught #t)

% Equality
#(assert-eq? assert assert)
#(assert-eqv? 3 (+ 1 2))
#(assert-equal? (list 1 2 3) (list 1 2 3))

% Comparison
#(assert< 1 2)
#(assert> 2 1)
#(assert<= 1 2)
#(assert<= 2 2)
#(assert>= 2 1)
#(assert>= 2 2)

% Assert an arbitrary expression
#(assert (string=? "abc" "abc"))

% The end: show number of assertions passed
#(assert-summary)