(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try steps guess)
    (display "-> ")
    (display guess)
    (display "#")
    (display steps)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          guess
          (try (+ steps 1) next))))
  (try 1 first-guess))

(define (average x y)
  (/ (+ x y) 2))

; noraml approach
(display "=== normal approach ===")
(newline)
(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)

; use average damping
(display "=== average damping ===")
(newline)
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2.0)
