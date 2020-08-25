(load "cont-frac.scm")

(define (tan-cf x k)
  (define (n i)
    (if (= i 1) x (- (* x x))))
  (define (d i)
    (- (* i 2) 1.0))
  (cont-frac-iterative n d k))

; tan(10) = 0.64836
(display (tan-cf 10 20))
