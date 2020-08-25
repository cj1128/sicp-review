(load "rational-numbers.scm")

(define (negate x)
  (if (< x 0) x (- x)))

(define (make-rat n d)
  (let ((g (gcd n d))
        (positive? (> (* n d) 0)))
    (if positive?
        (cons (/ (abs n) g) (/ (abs d) g))
        (cons (/ (negate n) g) (/ (abs d) g)))))

(print-rat (make-rat 3 8))
(print-rat (make-rat 3 -8))
(print-rat (make-rat -3 8))
(print-rat (make-rat -3 -8))
