(load "newtons-method")

(define (cubic a b c)
  (lambda (x)
    (+ (expt x 3) (* a (expt x 2)) (* b x) c)))

; x^3 - 2x^2 - 10x + 8 has a root 4
(display (newtons-method (cubic -2 -10 8) 3.0))

