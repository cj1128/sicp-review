;; Exercise 3.1
;; Write a procedure make-accumulator that generates accumulators

(define (make-accumulator sum)
  (lambda (n)
    (set! sum (+ sum n))
    sum))

(define a (make-accumulator 10))
(display (a 10))
(newline)

(display (a 10))
(newline)

(define b (make-accumulator 1))
(display (b 1))
(newline)

(display (b 100))
(newline)
