;;Finding fixed points of functions

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          guess
          (try next))))
  (try first-guess))


(display (fixed-point cos 1.0))
(display "\n")
(display (fixed-point (lambda (y) (+ (sin y) (cos y)))
                      1.0))

;;Use fixed-point to calculate square root
(define (square-root x)
  (fixed-point (lambda (y) (/ (+ y (/ x y)) 2))
               1.0))
(display "\n")
(display (square-root 38))
