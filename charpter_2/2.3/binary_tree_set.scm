;; Set implemented by binary tree

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond
   ((null? set) #f)
   ((= x (entry set)) #t)
   ((< x (entry set))
    (element-of-set? x (left-branch set)))
   ((> x (entry set))
    (element-of-set? x (right-branch set)))))


(define (adjoin-set x set)
  (cond
   ((null? set)
    (make-tree x '() '()))
   ((= x (entry set)) set)
   ((> x (entry set))
    (make-tree
     (entry set)
     (left-branch set)
     (adjoin-set x (right-branch set))))
   ((< x (entry set))
    (make-tree
     (entry set)
     (adjoin-set x (left-branch set))
     (right-branch set)))))
