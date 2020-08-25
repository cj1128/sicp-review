(load "fixed-point.scm")

; Find fixed-point of cos
(display (fixed-point cos 1.0))
(newline)

; Find a solution to the equation y = siny + cosy
(display (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0))
(newline)

; Use fixed-point to calculate square root
(define (square-root x)
  (fixed-point (lambda (y) (/ (+ y (/ x y)) 2))
               1.0))
(display (square-root 38))
