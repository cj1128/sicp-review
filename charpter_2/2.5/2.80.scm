;; Exercise 2.80
;; Define a generic procedure =zero? that tests if its agument is zero

(define (install-scheme-number-package)
  ;;....
  (define (=zero? x)
    (= x 0))
  (put '=zero? '(scheme-number) =zero?)
  'done)

(define (install-rational-package)
  ;;....
  (define (=zero? x)
    (= (numer x) 0))
  (put '=zero? '(rational) =zero?)
  'done)

(define (install-complex-package)
  (define (=zero? x)
    (and
     (= (real-part x) 0)
     (= (imag-part x) 0)))
  (put '=zero? '(complex complex) =zero?)
  'done)

(define (=zero? x)
  (apply-generic '=zero? x))
