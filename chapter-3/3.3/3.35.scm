;; Exercise 3.35
;; Fill in the missing portions to implement a squarer constraint


(load "../constraint-system/main.scm")

(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0: SQUARE" (get-value b))
            (set-value! a (sqrt (get-value b)) me))
        (set-value! b (square (get-value a)) me)))
  (define (process-no-value )
    (forget-value! a me)
    (forget-value! b me))
  (define (me request)
    (cond
      ((eq? request 'I-have-a-value) (process-new-value))
      ((eq? request 'I-lost-my-value) (process-no-value))
      (else (error "Unknown operation: SQUARER" request))))
  (connect a me)
  (connect b me)
  me)

(define a (make-connector))
(define b (make-connector))
(squarer a b)

(probe "Input" a)
(probe "Output" b)

(set-value! a 10 'user)

(forget-value! a 'user)

(set-value! b 300 'user)
