; The following procedure converts an *ordered list* to a balanced binary tree.

; The helper procedure `partial-tree` takes as arguments an integer `n` and list
; of at least n elements and constructs a balanced tree containing the first n
; elements of the list.

;; write a short paragraph explaining as clearly as you can how partial-tree works
;; think about the order of growth in the number of steps required by list->tree to convert a list of n elements

(define (make-tree entry left right)
  (list entry left right))

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


; a.
; Write a short paragraph explaining as clearly as you can
; how `partial-tree` works.

; `partial-tree` splits the list ELTS into three parts: the median item ENTRY, the list of items less than the median, and the list of items greater than the median. It creates a binary tree whose root node is ENTRY, whose left subtree is the partial-tree of the smaller elements, and whose right subtree is the partial-tree of the larger elements.

; Draw the tree produced by `list->tree` for the list (1 3 5 7 9 11)

(define l (list 1 3 5 7 9 11))
(display (list->tree l))

;    5
;  /    \
; 1      9
;  \    / \
;   3  7  11

; b.
; What is the order of growth in the number of steps required by `list->tree`
; to convert a list of n elements?

; T(n) = 2T(n/2) + O(1)
; So we get T(n) = O(n)
