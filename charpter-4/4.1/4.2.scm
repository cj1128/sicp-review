;; Exercise 4.2

;; a. what is wrong with Louis' plan?
;; Louis's evaluator will evaluate (define x e) as procedure call rather
;; than a variable definition

;; we need to redefine application? syntax procedure
(define (application? exp) (tagged-list exp 'call))
