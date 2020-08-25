(define (iterative-improve good-enough? improve)
  (define (iterate x)
    (if (good-enough? x) x (iterate (improve x))))
  (lambda (x)
    (iterate x)))

(define (fixed-point f first-guess)
  (define (good-enough? x)
    (< (abs (- x (f x))) 0.00001))
  (define (improve x)
    (f x))
  ((iterative-improve good-enough? improve) first-guess))

(define (sqrt x)
  (define (average x y)
    (/ (+ x y) 2))
  (define (good-enough? guess)
    (< (abs (- x (* guess guess))) 0.00001))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) 1.0))

(display (fixed-point cos 1.0))
(newline)

(display (sqrt 30))
(newline)

