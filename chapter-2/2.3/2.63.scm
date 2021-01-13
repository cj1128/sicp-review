(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))
(define (single-tree entry)
  (make-tree entry '() '()))

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

; trees from figure 2.16
(define tree1
  (make-tree
    7
    (make-tree 3
               (single-tree 1)
               (single-tree 5))
    (make-tree 9
               '()
               (single-tree 11))))

(define tree2
  (make-tree
    3
    (single-tree 1)
    (make-tree 7
               (single-tree 5)
               (make-tree 9
                          '()
                          (single-tree 11)))))

(define tree3
  (make-tree 5
             (make-tree 3
                        (single-tree 1)
                        '())
             (make-tree 9
                        (single-tree 7)
                        (single-tree 11))))

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
(newline)

; a.
; We can see that the two procedures produce the same results.

; b.
; Since `append` takes linear time but `cons` takes constant time, `tree->list-1` is slower.

; Here is the `append` definition
;(define (append list1 list2)
;  (if (null? list1) list2)
;  (cons (car list1) (append (cdr list1 list2))))
