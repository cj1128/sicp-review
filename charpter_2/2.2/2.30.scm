;; Exercise 2.30

(define (square-tree tree)
  (cond
   ((null? tree) '())
   ((pair? tree)
    (cons
     (square-tree (car tree))
     (square-tree (cdr tree))))
   (else (square tree))))


(define (square-tree-2 tree)
  (map
   (lambda (sub-tree)
     (if (pair? sub-tree)
         (square-tree-2 sub-tree)
         (square sub-tree)))
   tree))

(define tree '(1 (2 (3 4) 5) (6 7)))
(display (square-tree tree))
(newline)

(display (square-tree-2 tree))
