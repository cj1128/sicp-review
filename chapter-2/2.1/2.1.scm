;; Exercise 2.1

;; (gcd x y) is always positive
(define (negate x)
  (if (< x 0) x
      (- x)))

(define (make-rat n d)
  (let ((g (gcd n d))
           (positive? (> (* n d) 0)))
    (if positive?
        (cons (/ (abs n) g) (/ (abs d) g))
        (cons (/ (negate n) g) (/ (abs d) g)))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat 3 8))
(print-rat (make-rat 3 -8))
(print-rat (make-rat -3 8))
(print-rat (make-rat -3 -8))
