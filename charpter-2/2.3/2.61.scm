;; Exercise 2.61
;; Give an implementation of adjoin-set using the ordered representation

(define (adjoin-set x set)
  (cond
   ((= x (car set)) set)
   ((< x (car set)) (cons x set))
   (else (cons (car set) (adjoin-set x (cdr set))))))
