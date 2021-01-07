; union-set for the unordered-list representation of sets
(define (union-set set1 set2)
  (cond
    ((null? set1) set2)
    ((null? set2) set1)
    ((element-of-set? (car set1) set2)
     (union-set (cdr set1) set2))
    (else (cons
            (car set1)
            (union-set (cdr set1) set2)))))
