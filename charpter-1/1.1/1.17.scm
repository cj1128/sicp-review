;;Exercise 1.17
;;Design a multiplication procedure analogous to fast-expn

(define (double x)
  (+ x x))
(define (halve x)
  (/ x 2))

(define (fast-mul a b)
  (cond
    ((= b 1) a)
    ((even? b) (fast-mul (double a) (halve b)))
    (else (+ a (fast-mul (double a) (halve (- b 1)))))))

(display (fast-mul 2 100))