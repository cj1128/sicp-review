;;Exercise 1.8

(define (improve guess x)
  (/
    (+ (/ x (square guess)) (* 2 guess))
    3))
(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (improve guess x) guess)) 0.00001))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
    guess
    (cube-root-iter (improve guess x) x)))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(display (cube-root 27))