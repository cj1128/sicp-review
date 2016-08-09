;; Exercise 3.55
;; Define a procedure partial-sums that takes as argument a stream S
;; and returns the stream whose elements are s0, s0+s1, s0+s1+s2...


(define (stream-add s1 s2)
  (stream-map + s1 s2))

(define (partial-sums s)
  (define result
    (cons-stream (stream-car s)
      (stream-add  result (stream-cdr s))))
  result)

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(display (stream-ref (partial-sums integers) 4))
