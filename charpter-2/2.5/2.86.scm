;; Exercise 2.86
;; Suppose we want to handle complex numbers whose real parts, imaginary parts, magnitudes, and angles can be either ordinary numbers, rational numbers, or other numbers we might wish to add to the system.
;; Describe and implement the changes to the system needed to accomplish this

;; Suppose we have add, sub, mul, div generic operations

;; First we define some generic operations
(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (arctan x) (apply-generic 'arctan x))
(define (exp x y) (apply-generic 'exp x y))

;; add these operations to rational package
(put 'sine '(rational) (lambda (x) (tag (sin x))))
(put 'cosine '(rational) (lambda (x) (tag (cos x))))
(put 'arctan '(rational) (lambda (x) (tag (atan x))))
(put 'exp '(rational rational) (lambda (x y) (expt x y)))

;; compolex-rect package
(define (square x) (mul x x))
(define (sqrt x) (exp x 0.5))
(define (make-from-mag-ang r a)
  (cons (mul r (cosine a))
        (mul r (sine a))))
(define (magnitude z)
  (sqrt (add (square (real-part z))
             (square (imag-part z)))))
(define (angle z)
  (arctan (div (imag-part z)
               (real-part z))))

;; complex-polar package
(define (real-part z) (mul (magnitude z) (cosine (angle z))))
(define (imag-part z) (mul (magnitude z) (sine (angle z))))

;; complex package
(define (add-complex x y)
  (make-from-real-imag
   (add (real-part x)
        (real-part y))
   (add (imag-part x)
        (imag-part y))))

;; ... the others are the same
