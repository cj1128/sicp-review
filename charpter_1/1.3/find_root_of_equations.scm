;;Use half-interval to find roots of equations
(define (search f neg-point pos-point)
  (let ((midpoint
         (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond
           ((positive? test-value)
            (search f neg-point midpoint))
           ((negative? test-value)
            (search f midpoint pos-point))
           (else midpoint))))))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))

(define (average x y) (/ (+ x y) 2))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond
     ((and (positive? a-value) (negative? b-value))
      (search f b a))
     ((and (positive? b-value) (negative? a-value))
      (search f a b))
     (else (error "Values are not of opposite sign" a b)))))

(display (half-interval-method sin 2.0 4.0))
(display "\n")
(display (half-interval-method
          (lambda (x) (- (* x x x) (* 2 x) 3))
          1.0
          2.0))
