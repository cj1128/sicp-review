(load "cont-frac.lib.scm")

(define (d i)
  (cond
   ((= i 1) 1)
   ((= i 2) 2)
   ((= 0 (remainder (- i 2) 3)) (* 2 (/ (+ i 1) 3)))
   (else 1)))

; 2.718281828459045
(display (+ 2 (cont-frac-iterative (lambda (i) 1.0) d 20)))
