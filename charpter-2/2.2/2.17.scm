;; Exercise 2.17

(define (last-pair l)
  (cond
   ((= (length l) 0) (error "Can't apply last-pair to empty list"))
   ((= (length l) 1) l)
   (else (last-pair (cdr l)))))

(display (last-pair (list 1 2 3 4)))
