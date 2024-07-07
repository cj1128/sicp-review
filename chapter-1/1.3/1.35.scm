(load "fixed-point.lib.scm")

(display (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))
