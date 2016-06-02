\version "2.18.2"
\require "assert:.."

% When an assertion fails it throws an error
% Here we catch the error and set the error-thrown flag
% (This is basically identical to the assert:throw function)
#(define error-thrown #f)
#(catch #t (lambda () (assert:eq? 1 2))
  (lambda (key . parameters) (set! error-thrown #t))
)
#(assert:eq? error-thrown #t)

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

% Assert failure messages
#(catch #t (lambda () (assert:eq? 1 2))
  (lambda (key . params)
    (assert:string=? (list-ref params 1) "expected 1 to eq? 2")
  )
)

#(catch #t (lambda () (assert:equal? 1 2))
  (lambda (key . params)
    (assert:string=? (list-ref params 1) "expected 1 to equal? 2")
  )
)

#(catch #t (lambda () (assert:compare 1 2))
  (lambda (key . params)
    (assert:string=? (list-ref params 1) "expected 1 but got 2")
  )
)
