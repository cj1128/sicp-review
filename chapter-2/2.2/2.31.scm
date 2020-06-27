;; Exercise 2.31

(define (tree-map proc tree)
  (cond
   ((null? tree) '())
   ((pair? tree)
    (cons
     (tree-map proc (car tree))
     (tree-map proc (cdr tree))))
   (else (proc tree))))

(define (square-tree tree)
  (tree-map square tree))

(define tree '(1 (2 (3 4) 5) (6 7)))

(display (square-tree tree))
