; Based on https://github.com/axch/test-manager/blob/master/assertions.scm
; by Alexey Radul

(define assert-count 0)

(define (test-fail message)
  (throw 'test-failure "test-fail" message #f))

(define (assert-proc message proc)
  (if (proc)
      'ok
      (test-fail message)))

(define (assert-equivalent predicate . opt-pred-name)
  (define (full-message message expected actual)
    (if (null? opt-pred-name)
  (format "expected ~a but got ~a" expected actual)
  (format "expected ~a to be ~a to ~a" expected (car opt-pred-name) actual)))
  (lambda (expected actual . opt-message)
    (set! assert-count (+ 1 assert-count))
    (let-optional 
     opt-message ((message #f))
     (assert-proc (full-message message expected actual)
		  (lambda () (predicate expected actual))))))

(define (assert expr) (assert-proc "assertion failed" (lambda () expr)))
(define assert-eq? (assert-equivalent eq? "eq?"))
(define assert-eqv? (assert-equivalent eqv? "eqv?"))
(define assert-equal? (assert-equivalent equal? "equal?"))
(define assert= (assert-equivalent = "="))
(define assert< (assert-equivalent < "<"))
(define assert> (assert-equivalent > ">"))
(define assert<= (assert-equivalent <= "<="))
(define assert>= (assert-equivalent >= ">="))

(define (assert-summary)
  (display (format "\n~a assertion(s) passed!" assert-count))
)