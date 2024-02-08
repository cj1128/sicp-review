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

(display (square (sqrt 1e-5)))
(newline)

; very large number
(display (square (sqrt 1e300)))
(newline)
