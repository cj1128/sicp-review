(load "fixed-point.lib.scm")

; y = cos(y)
; 0.739089
(display (fixed-point cos 1.0))
(newline)

; y = sin(y) + cos(y)
; 1.258722
(display (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0))

; calculate square root, y = x/y -> y = 1/2(y + x/y)
(define (square-root x)
  (fixed-point (lambda (y) (/ (+ y (/ x y)) 2))
               1.0))
(display (square-root 38))
