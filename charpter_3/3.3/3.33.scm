;; Exercise 3.33
;; Using primitive multiplier, adder and constant constraints
;; define a procedure averager that takes three connectors a, b, c
;; as inputs and establishes the constraint that the value of c
;; is the average of the values of a and b

(load "../constraint-system/main.scm")

(define (averager a b c)
  (let ((s (make-connector))
        (e (make-connector)))
    (adder a b s)
    (multiplier s e c)
    (constant 0.5 e)))

(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(averager a b c)

(probe "Input 1" a)
(probe "Input 2" b)
(probe "Average" c)

(set-value! a 10 'user)
(set-value! b 20 'user)


(forget-value! b 'user)
(set-value! b 100 'user)

