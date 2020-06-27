;; Exercise 3.73
;; write a procedure RC that models the RC circuit

(define (integral integrand initial-value dt)
  (define int
    (cons-stream
      initial-value
      (stream-add (stream-scale integrand dt)
                  int)))
  int)

(define (RC R C dt)
  (lambda (i v0)
    (cons-stream
      v0
      (stream-add
        (stream-scale i R)
        (integral
          (stream-scale i (/ 1 c))
          v0
          dt)))))
