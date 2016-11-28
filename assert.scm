; Loosely based on Alexey Radul's the scheme assertions code:
; https://github.com/axch/test-manager/blob/master/assertions.scm

(define assert:count 0)

(define (assert:fail message)
  (throw 'assert:failure "assert:fail" message #f))

(define (assert:proc message proc)
  (if (proc) (set! assert:count (+ 1 assert:count)) (assert:fail message)))

(define (assert:compare-fn predicate . expected-got)
  (define (fail-message message x y)
    (if (null? expected-got)
      (format "expected ~a to ~a ~a" x (procedure-name predicate) y)
      (format "expected ~a but got ~a" x y)))
  (lambda (x y . opt-message)
    (let-optional opt-message ((message #f))
      (assert:proc (fail-message message x y)
		    (lambda () (predicate x y))))))

(define (assert expr) (assert:proc "assertion failed" (lambda () expr)))
(define assert:compare (assert:compare-fn equal? #t))
(define assert:eq? (assert:compare-fn eq?))
(define assert:eqv? (assert:compare-fn eqv?))
(define assert:equal? (assert:compare-fn equal?))
(define assert= (assert:compare-fn =))
(define assert< (assert:compare-fn <))
(define assert> (assert:compare-fn >))
(define assert<= (assert:compare-fn <=))
(define assert>= (assert:compare-fn >=))
(define assert:string=? (assert:compare-fn string=?))

(define (assert:throw proc)
  (let* ((error-thrown #f))
    (catch #t
      (lambda () (proc))
      (lambda (key . parameters) (set! error-thrown #t)))
    (assert:proc "Expected error but none thrown" (lambda () error-thrown))))

(define (assert:summary)
  (display (format "\n~a assertion(s) passed!" assert:count)))

(lyp:finalize assert:summary)