(define (sqrt-iter lastguess guess x)
  (if (good-enough? lastguess guess)
    guess
    (sqrt-iter guess (improve guess x) x)))

(define (good-enough? lastguess guess) (< (abs (- lastguess guess)) 0.001))

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))

(define (sqrt x) (sqrt-iter 0 1.0 x))

(display (sqrt 3))
; 1.7320508100147274
(newline)

(display (sqrt 4))
; 2.0000000929222947
(newline)

; very small number
(display (sqrt 0.00001))
; 3.172028655357483e-3
(newline)

(display (square (sqrt 0.00001)))
; 1.0061765790409001e-5
(newline)

; very large number
(display (sqrt 1.797693134862315708145274237317043567981e+308))
; 1.3407807929942597e154
(newline)
