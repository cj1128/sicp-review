;; Exercise 3.37
;; Define procedures c-,c*,c/ and cv that enable us
;; to define compound constraints in a more expression-oriented style

(load "../constraint-system/main.scm")

(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
    z))

(define (c* x y)
  (let ((product (make-connector)))
    (multiplier x y product)
    product))

(define (c/ x y)
  (let ((z (make-connector)))
    (multiplier y z x)
    z))

(define (cv value)
  (let ((z (make-connector)))
    (constant value z)
    z))

(define (celsius-fahrenheit-converter x)
  (c+
    (c*
      (c/ (cv 9) (cv 5))
      x)
    (cv 32)))

(define C (make-connector))
(define F (celsius-fahrenheit-converter C))

(probe "Celsius" C)
(probe "Fahrenheit" F)

(set-value! C 25 'user)
(forget-value! C 'user)

(set-value! F 212 'user)

