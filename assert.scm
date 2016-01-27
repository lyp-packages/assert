; Loosely based on Alexey Radul's the scheme assertions code:
; https://github.com/axch/test-manager/blob/master/assertions.scm

(define assert:count 0)

(define (assert:fail message) (throw 'assert:failure "assert:fail" message #f))

(define (assert:proc message proc) (begin
  (set! assert:count (+ 1 assert:count))
  (if (proc) 'ok (assert:fail message))
))

(define (assert:compare-fn predicate . opt-pred-name)
  (define (fail-message message expected actual)
    (if (null? opt-pred-name)
      (format "expected ~a but got ~a" expected actual)
      (format "expected ~a to ~a ~a" expected (car opt-pred-name) actual)
    )
  )
  (lambda (expected actual . opt-message)
    (let-optional opt-message ((message #f))
      (assert:proc (fail-message message expected actual)
		    (lambda () (predicate expected actual))))
  )
)

(define (assert expr) (assert:proc "assertion failed" (lambda () expr)))
(define assert:compare (assert:compare-fn equal?))
(define assert:eq? (assert:compare-fn eq? "eq?"))
(define assert:eqv? (assert:compare-fn eqv? "eqv?"))
(define assert:equal? (assert:compare-fn equal? "equal?"))
(define assert= (assert:compare-fn = "="))
(define assert< (assert:compare-fn < "<"))
(define assert> (assert:compare-fn > ">"))
(define assert<= (assert:compare-fn <= "<="))
(define assert>= (assert:compare-fn >= ">="))

(define (assert:throw proc) (let* ((error-thrown #f))
  (catch #t
    (lambda () (proc))
    (lambda (key . parameters) (set! error-thrown #t))
  )
  (assert:proc "Expected error but none thrown" (lambda () error-thrown))
))

(define (assert:summary)
  (display (format "\n~a assertion(s) passed!" assert:count))
)