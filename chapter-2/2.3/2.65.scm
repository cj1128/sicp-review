(load "./set-as-binary-tree.scm")

; We have implemented O(n) `union-set` and O(n) `intersection-set` for ordered list,
; So we can use tree->list to convert a binary tree to a list
; and perform operations, after then we can use list->tree to convert
; list to a binary tree,
; The overall complixety would be O(n).

(define (union-set-for-ordered-list set1 set2)
  (cond
    ((null? set1) set2)
    ((null? set2) set1)
    ((= (car set1) (car set2))
     (cons (car set1) (union-set-for-ordered-list (cdr set1) (cdr set2))))
    ((< (car set1) (car set2))
     (cons (car set1) (union-set-for-ordered-list (cdr set1) set2)))
    ((< (car set2) (car set1))
     (cons (car set2) (union-set-for-ordered-list set1 (cdr set2))))))

(define (intersection-set-for-ordered-list set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond
          ((= x1 x2)
           (cons x1
                 (intersection-set-for-ordered-list (cdr set2) (cdr set1))))
          ((< x1 x2)
           (intersection-set-for-ordered-list (cdr set1) set2))
          ((< x2 x1)
           (intersection-set-for-ordered-list set1 (cdr set2)))))))

(define (union-set s1 s2)
  (let ((l1 (tree->list s1))
        (l2 (tree->list s2)))
    (list->tree (union-set-for-ordered-list l1 l2))))

(define (intersection-set s1 s2)
  (let ((l1 (tree->list s1))
        (l2 (tree->list s2)))
    (list->tree (intersection-set-for-ordered-list l1 l2))))

(define tree1 (list->tree '(1 3 5 7 9 11)))
(define tree2 (list->tree '(2 4 6 8 10 11 12)))

; tree; (entry left right)
(define (print-tree tree)
  (define (print tree indent)
    (if (not (null? tree))
        (begin
          (print (cadr tree) (string-append "  " indent))
          (display indent)
          (display (car tree))
          (newline)
          (print (caddr tree) (string-append "  " indent)))))
  (print tree ""))

(print-tree (union-set tree1 tree2))
(newline)

(display (intersection-set tree1 tree2))
