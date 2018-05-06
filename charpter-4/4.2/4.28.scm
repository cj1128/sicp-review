;; Exercise 4.28
;; eval uses actual-value rather than eval to evaluate the operator
;; before passing it to apply.
;; Give an example that demonstrates the need for this forcing

(define (t x) (x 1 2))
(define a (t +))
