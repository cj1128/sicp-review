;;Exercise 1.7

(define (square x)
  (* x x))

(define (abs x)
  (if (>= x 0) x (- x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (new-good-enough? guess x)
  (< (abs (- guess (improve guess x))) 0.001))

(define (old-good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (new-good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(display (sqrt 0.0000000016))


