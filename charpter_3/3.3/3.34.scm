;; Exercise 3.34
;; Explain the serious flaw in following squarer constraint

(load "../constraint-system/main.scm")

(define (squarer a b)
  (multiplier a a b))

;(set-value! b 100 'user)
;; we can't get value a through above code, because multiplier doesn't
;; have enough information to calculate a
