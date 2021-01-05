
; a
; Assume that + and * always take two arguments and the expressions are fully
; parenthesized.

(load "basic.scm")

(define (sum? x)
  (and
    (pair? x)
    (eq? '+ (cadr x))))

(define (make-sum a1 a2)
  (cond
    ((=number? a1 0) a2)
    ((=number? a2 0) a1)
    ((and
       (number? a1)
       (number? a2))
     (+ a1 a2))
    (else
      (list a1 '+ a2))))

(define (addend x)
  (car x))

(define (augend x)
  (let
    ((item (cddr x)))
    (if (= 1 (length item))
        (car item)
        item)))

(define (product? x)
  (and
    (pair? x)
    (eq? '* (cadr x))))

(define (make-product m1 m2)
  (cond
    ((or (=number? m1 0)
         (=number? m2 0))
     0)
    ((=number? m1 1) m2)
    ((=number? m2 1) m1)
    ((and
       (number? m1)
       (number? m2))
     (* m1 m2))
    (else (list m1 '* m2))))

(define (multiplier p)
  (car p))

(define (multiplicand p)
  (let
    ((item (cddr p)))
    (if (= (length item) 1)
        (car item)
        item)))

(display (deriv '(x + (3 * (x + (y + 2)))) 'x))
