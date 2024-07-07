(load "cont-frac.lib.scm")

(define (tan-cf x k)
  (define (n i)
    (if (= i 1) x (- (* x x))))
  (define (d i)
    (- (* i 2) 1.0))
  (cont-frac-iterative n d k))

(display "correct answer: ")
(display (/ (sin 10) (cos 10)))
(newline)

(display "our approximation: ")
(display (tan-cf 10 20))
