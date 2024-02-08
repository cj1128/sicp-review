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

(define (cube x) (* x x x))

(display (cube (cube-root 3)))
(newline)

(display (cube (cube-root 4)))
(newline)

;; very small number
(display (cube (cube-root 1e-5)))
(newline)

;; very large number
(display (cube (cube-root 1e300)))
(newline)
