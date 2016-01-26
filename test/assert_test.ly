\version "2.18.2"
\include "../package.ly"

#(define error-caught #f)

#(catch #t
  (lambda () (assert-eq? 1 2))
  (lambda (key . parameters)
    (set! error-caught #t)
  )
)

#(assert-eq? error-caught #f)
