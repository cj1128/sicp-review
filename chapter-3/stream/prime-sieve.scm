(define (divisible? x y)
  (= (remainder x y) 0))

(define (sieve stream)
  (cons-stream
    (stream-car stream)
    (sieve (stream-filter
             (lambda (x)
               (not (divisible? x (stream-car stream))))
             (stream-cdr stream)))))

(define (integers-starting-from x)
  (cons-stream x
    (integers-starting-from (+ x 1))))

(define prime (sieve (integers-starting-from 2)))

(display (stream-ref prime 100))
