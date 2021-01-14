;; Set implemented as binary tree

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; O(logn) for balanced tree
(define (element-of-set? x set)
  (cond
    ((null? set) false)
    ((= x (entry set)) true)
    ((< x (entry set))
     (element-of-set? x (left-branch set)))
    ((> x (entry set))
     (element-of-set? x (right-branch set)))))

; O(logn) for balanced tree
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

; O(n)
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                              (right-branch tree) result-list)))))
  (copy-to-list tree '()))

; O(n)
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
