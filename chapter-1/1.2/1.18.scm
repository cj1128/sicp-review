(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (mul a b)
  (define (iter s a b)
    (cond
      ((= b 1) (+ s a))
      ((even? b) (iter s (double a) (halve b)))
      (else (iter (+ s a) (double a) (halve (- b 1))))))
  (iter 0 a b))

(display (mul 2 100))
(newline)

(display (mul 3 7))
