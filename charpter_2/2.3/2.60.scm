;; Exericse 2.60

;; We don't need to change definition of element-of-set?
;; adjoin-set and union-set will be simplified if we allow duplicate elements
;; the drawback of duplicate elements is that it need more memory

(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (append set1 set2))
