;; Exercise 3.61
;; Write a procedure invert-unit-series that computes 1/S for
;; a power series S with constant term 1

;; X = 1/S
;; S = 1 + SR
;; X = 1 - SR*X

(define (invert-unit-series s)
  (define result
    (cons-stream 1
                 (stream-scale
                   (mul-series (stream-cdr s) result)
                   -1))))
