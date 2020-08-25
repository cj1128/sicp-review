; φ = 1.618033
; 1/φ = 0.618033

(load "cont-frac.scm")

;; k = 11 is enough to be accurate to 4 decimal places
(display "recursive:\n")
(display (cont-frac-recursive (lambda (i) 1.0)
                              (lambda (i) 1.0) 11))

(newline)

(display "iterative:\n")
(display (cont-frac-iterative (lambda (i) 1.0)
                              (lambda (i) 1.0) 11))
