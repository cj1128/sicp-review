;; Exercise 1.41

(define (inc x)
  (+ x 1))

(define (double f)
  (lambda (x)
    (f (f x))))

(display ((double inc) 1))
(newline)
(display (((double (double double)) inc) 5))
