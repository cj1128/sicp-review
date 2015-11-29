;; Exercise 2.63
;; Compare two procedures which convert a binary tree to a list

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


(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons
               (entry tree)
               (tree->list-2 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                             (right-branch tree) result-list)))))
  (copy-to-list tree '()))

;; Trees from figure 2.16
(define tree1 (make-tree 7
                         (make-tree 3 '(1 () () ) '(5 () ()))
                         (make-tree 9 '() '(11 () ()))))
(define tree2 (make-tree 3
                         (make-tree 1 '() '())
                         (make-tree 7 '(5 () ())
                                    (make-tree 9 '() '(11 () ())))))
(define tree3 (make-tree 5
                         (make-tree 3 '(1 () ()) '())
                         (make-tree 9 '(7 () ())
                                    '(11 () ()))))

(display (tree->list-1 tree1))
(newline)
(display (tree->list-2 tree1))
(newline)

(display (tree->list-1 tree2))
(newline)
(display (tree->list-2 tree2))
(newline)

(display (tree->list-1 tree3))
(newline)
(display (tree->list-2 tree3))


;; We can see that two procedures procedure the same results, both are ordered list of the tree

;; each procedure takes same steps, but in each step it has a subtle difference and that is caused by cons and append

;; append definition
(define (append list1 list2)
  (if (null? list1) list2)
  (cons (car list1) (append (cdr list1 list2))))
