(load "sd-basic.scm")

; For exponentiation

(define (exponentiation? exp)
  (eq? (car exp) '**))

(define (base exp)
  (cadr exp))

(define (exponent exp)
  (caddr exp))

(define (make-exponentiation base exponent)
  (cond
    ((= exponent 0) 1)
    ((= exponent 1) base)
    (else
      (list '** base exponent))))

(define (deriv exp var)
  (cond
    ((number? exp) 0)
    ((variable? exp)
     (if (same-variable? exp var)
         1 0))
    ((sum? exp)
     (make-sum
       (deriv (addend exp) var)
       (deriv (augend exp) var)))
    ((product? exp)
     (make-sum
       (make-product
         (multiplier exp)
         (deriv (multiplicand exp) var))
       (make-product
         (multiplicand exp)
         (deriv (multiplier exp) var))))
    ((exponentiation? exp)
     (let
       ((base (base exp))
        (exponent (exponent exp)))
       (make-product
         (make-product
           exponent
           (make-exponentiation base (- exponent 1)))
         (deriv base var))))
    (else (error "unknown expression type: DERIV" exp))))

; sum
(display (deriv '(+ x 3) 'x))
(newline)

; product
(display (deriv '(* x y) 'x))
(newline)

; exponentiation
(display (deriv '(** x 3) 'x))
(newline)

; overall
(display (deriv '(* (* x y) (+ x 3)) 'x))
