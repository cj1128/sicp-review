(define tolerance 0.00001)

(load "fixed-point.scm")

(display (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))
