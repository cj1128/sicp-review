;; Exercise 3.26
;; Describe a table implementation where the (key,value) records are
;; organized using a binary tree.
;; Assuming that keys can be ordered in some way
;; node structure: (key value big-child small-child)


(define (set-nth list n val)
  (if (> n 0)
      (cons (car list)
            (set-nth (cdr list) (- n 1) val))
      (cons val (cdr list))))

(define (make-table)
  (define (get-node key root)
    (let ((root-key (get-key root)))
      (cond
        ((null? root) #f)
        ((eq? key root-key) root)
        ((> key root-key) (get-node key (big-child root)))
        (else (get-node key (small-child root))))))
  (define (big-child node)
    (list-ref node 2))
  (define (set-big-child node child)
    (set-nth node 2 child))
  (define (small-child node)
    (list-ref node 3))
  (define (set-small-child node child)
    (set-nth node 3 child))
  (define (get-key node)
    (if (null? node) #f (car node)))
  (define (get-value node)
    (list-ref node 1))
  (define (set-value node value)
    (set-car! node value))
  (define (insert-node root key value)
    (cond
      ((null? root) (list key value '() '()))
      ((> key (get-key root))
       (set-big-child
         root
        (insert-node (big-child root) key value)))
      ((< key (get-key root))
       (set-small-child
         root
        (insert-node (small-child root) key value)))))
  (let ((local-table (list '*table)))
    (define (lookup key)
      (let ((node (get-node key (cdr local-table))))
        (if node
          (get-value node)
          #f)))
    (define (insert! key value)
      (let ((node (get-node key (cdr local-table))))
        (if node
            (set-value node value)
            (let ((root (cdr local-table)))
            (set-cdr! local-table (insert-node root key value))))))
    (define (dispatch m)
      (cond
        ((eq? m 'insert-proc) insert!)
        ((eq? m 'lookup-proc) lookup)
        ((eq? m 'debug) (lambda () local-table))
        (else (error "No such operation" m))))
    dispatch))

(define table (make-table))
(define get (table 'lookup-proc))
(define put (table 'insert-proc))
(define local-table (table 'debug))

(put 50 'a)
(put 10 'j)
(put 20 'b)
(put 30 'c)
(put 40 'd)

(put 60 'f)
(put 70 'g)
(put 80 'h)
(put 90 'i)
(put 100 'e)

(display (get 10))
(newline)

(display (get 100))
(newline)

; debug
;(display (local-table))
;(newline)
