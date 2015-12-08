;; Exercise 2.83
;; Suppose you are dealing with a generic arithmetic system for dealing with the tower of types: integer, rational, real, complex. For each type(except complex), design a procedure that raises objects of that type one level in the tower.

(define (install-integer-package)
  ;;...
  (define (raise x)
    (make-rational x 1))
  (put 'raise '(integer) raise))


(define (install-rational-package)
  ;;...
  (define (raise x)
    (make-real x))
  (put 'raise '(rational) raise))

(define (install-real-package)
  ;;...
  (define (raise x)
    (make-from-real-imag x 0))
  (put 'raise '(real) raise))

(define (raise x)
  (apply-generic 'raise x))
