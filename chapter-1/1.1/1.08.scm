(define (cube-root-iter lastguess guess x)
  (if (good-enough? lastguess guess)
      guess
      (cube-root-iter guess (improve guess x) x)))

(define (good-enough? lastguess guess) (< (abs (- lastguess guess)) 0.001))

(define (improve guess x)
  (/
    (+
      (* 2 guess)
      (/ x (* guess guess)))
    3))

(define (cube-root x) (cube-root-iter 0 1.0 x))

(display (cube-root 3))
(newline)

(display (cube-root 4))
(newline)

;; very small number
(display (cube-root 0.00001))
(newline)

;; very large number
(display (sqrt 1.797693134862315708145274237317043567981e+308))
(newline)
