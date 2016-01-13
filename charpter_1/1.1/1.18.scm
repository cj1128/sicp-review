;;Exercise 1.18
;;Devise a iterative procedure to calculate multiplication
(define (double x)
  (+ x x))
(define (halve x)
  (/ x 2))
(define (even? x)
  (= (remainder x 2) 0))

(define (fast-mul s a b)
  (cond
    ((= b 1) (+ s a))
    ((even? b) (fast-mul s (double a) (halve b)))
    (else (fast-mul (+ s a) (double a) (halve (- b 1))))))

(define (mul a b)
  (fast-mul 0 a b))

(display (mul 2 100))