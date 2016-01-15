;; Exercise 3.13
;; Consider the following make-cycle procedure
;; Draw a box-pointer diagram that shows the structure z
;; created by the following expression

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

;(display z)

;; What happened if we try to compute (last-pair z) ?
;; We will get an infinite loop
