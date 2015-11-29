;; Exercise 2.64
;; the following procedure converts an ordered list to a balanced binary tree
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

(define l (list 1 3 5 7 9 11))
(display (list->tree l))

;; partial-tree接受一个列表以及需要转换的元素个数n，返回一个pair,
;; car为转换好的tree，cdr为剩下的元素
;; list->tree不停调用partial-tree就可以实现将一个有序列表转换为一颗二叉树,
;; 因为对于一个有序列表而言，哪个元素是树根哪个是左树哪个是右树是非常清楚的
;; 至于为什么要返回剩余的元素，是为了避免切割列表。也可以选择切割列表，然后让partial-tree只返回转换二叉树


;; Order of growth: O(n)
