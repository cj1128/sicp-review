(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x) (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (/ (+ guess (/ x guess)) 2))

(define (sqrt x) (sqrt-iter 1.0 x))

(display (sqrt 3))
(newline)

(display (sqrt 4))
(newline)

(display (square (sqrt 1001)))
(newline)

; very small number
(display (sqrt 0.00001))
(newline)

(display (square (sqrt 0.00001)))
(newline)

; very large number
; CAUTION! this will run forever
;(display (sqrt 1.797693134862315708145274237317043567981e+308))
;(newline)
