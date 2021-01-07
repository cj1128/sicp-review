; this procedure is the same as the non-duplicate set.
; we still have to iterate the whole list.
(define (element-of-set? x set)
  (cond
    ((null? set) #f)
    ((equal? x (car set)) #t)
    (else (element-of-set? (cdr set)))))

; this procedure is simplified and only takes constant time
(define (adjoin-set x set)
  (cons x set))

; this procedure is simplified too
(define (union-set set1 set2)
  (append set1 set2))

; If we don't care the memory usage and want faster
; adjoin-set and union-set operations, we can use
; this representation.
