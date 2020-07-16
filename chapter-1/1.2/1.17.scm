(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (mul a b)
  (cond
    ((= b 1) a)
    ((even? b) (double (mul a (halve b))))
    (else (+ a (mul a (- b 1))))))

(display (mul 2 100))
(newline)

(display (mul 3 7))
