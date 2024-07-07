(define (average a b) (/ (+ a b) 2))

(define (close-enough? a b) (< (abs (- a b)) 0.001))

(define (search f neg-point pos-point)
  (let ((mid-point (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point) mid-point
        (let ((test-value (f mid-point)))
          (cond
            ((positive? test-value) (search f neg-point mid-point))
            ((negative? test-value) (search f mid-point pos-point))
            (else mid-point))))))

(define (half-interval f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (positive? a-value) (negative? b-value))
           (search f b a))
          ((and (positive? b-value) (negative? a-value))
           (search f a b))
          (else (error "Values are not of opposite sign" a b)))))

(display (half-interval sin 2.0 4.0))
(newline)

; x^3 - 2x -3 = 0
(display (half-interval (lambda (x) (- (* x x x) (* 2 x) 3)) 1.0 2.0))
