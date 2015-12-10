;; Exercise 2.85
;; Design a procedure drop that can simplify a data object by lowering it in the tower of types as far as possible
;; integer -> rational -> real -> complex


(define (install-rational-package)
  ;;...
  (define (project x)
    (make-scheme-number
     (round (/ (numer x) (denom x)))))
  (put 'project '(rational) project))

(define (install-real-package)
  ;;...
  (define (project x)
    (let
        ((rat (rationalize
               (inexact->exact x) 1/100)))
      (make-rational
       (numerator rat)
       (denominator rat))))
  (put 'project '(real) project))

(define (install-integer-package)
  ;;...
  (define (project x)
    (make-real (real-part x)))
  (put 'project '(complex) project))

(define (project x)
  (apply-generic 'project x))

(define (drop x)
  (if (eq? (type-tag x) 'scheme-number)
      x
      (let
          ((projected (project x)))
        (if (equ?
             (raise projected) x)
            (drop projected)
            x))))



;; apply-generic
;; the only change is to apply drop to the result
(drop (apply proc (map contents args)))
