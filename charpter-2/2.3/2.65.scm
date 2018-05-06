;; Exercise 2.65
;; Give O(n) implementation of union-set and intersection-set for sets implemented as balanced binary tree

;; We have implemented O(n) union-set and O(n) intersection-set for ordered list,
;; so we can use tree->list to convert a binary tree to a list and perform operations, after then we can use list->tree to convert list to a binary tree,
;; and the complixety will be O(n)
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                             (right-branch tree) result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree
                                 (cdr non-left-elts)
                                 right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

(define (union-set-ordered-list set1 set2)
  (cond
   ((null? set1) set2)
   ((null? set2) set1)
   ((= (car set1) (car set2))
    (cons (car set1) (union-set-ordered-list (cdr set1) (cdr set2))))
   ((< (car set1) (car set2))
    (cons (car set1) (union-set-ordered-list (cdr set1) set2)))
   ((< (car set2) (car set1))
    (cons (car set2) (union-set-ordered-list set1 (cdr set2))))))

(define (intersection-set-ordered-list set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond
         ((= x1 x2)
          (cons x1
                (intersection-set-ordered-list (cdr set2) (cdr set1))))
         ((< x1 x2)
          (intersection-set-ordered-list (cdr set1) set2))
         ((< x2 x1)
          (intersection-set-ordered-list set1 (cdr set2)))))))

(define (union-set s1 s2)
  (let ((l1 (tree->list s1))
        (l2 (tree->list s2)))
    (list->tree (union-set-ordered-list l1 l2))))

(define (intersection-set s1 s2)
  (let ((l1 (tree->list s1))
        (l2 (tree->list s2)))
    (list->tree (intersection-set-ordered-list l1 l2))))

(define tree1 (list->tree '(1 3 5 7 9 11)))
(define tree2 (list->tree '(2 4 6 8 10 11 12)))

(display (union-set tree1 tree2))
(newline)

(display (intersection-set tree1 tree2))
