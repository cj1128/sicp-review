(load "compose.scm")

(define (repeated f n)
  (define (iterate g k)
    (if (= k n) g
        (iterate (compose f g) (+ k 1))))
  (iterate f 1))
