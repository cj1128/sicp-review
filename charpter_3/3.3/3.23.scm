;; Exercise 3.23
;; Implements a deque(double ended queue)
;; All operations should be completed in O(1) steps

;; front ptr, rear ptr, and one before rear ptr
(define (make-deque)
  (cons '() '()))
(define (empty-deque? deque)
  (null? (front-deque deque)))
(define (set-front-ptr! deque pair)
  (set-car! deque pair))
(define (set-rear-ptr! deque pair)
  (set-cdr! deque pair))

(define (make-node item)
  (cons item '()))
(define (set-node-ptr! node item)
  (set-cdr! node item))
(define (get-node-pair node)
  (cdr node))
(define (get-node-from-pair pair)
  (car pair))

(define (front-deque deque)
  (car deque))
(define (rear-deque deque)
  (cdr deque))

(define (front-insert-deque! deque item)
  (let ((node (make-node item)))
    (let ((new-pair (cons node '())))
      (if (empty-deque? deque)
          (begin
            (set-front-ptr! deque new-pair)
            (set-rear-ptr! deque new-pair)
            deque)
          (begin
            (set-node-ptr! (get-node-from-pair (front-deque deque)) new-pair)
            (set-cdr! new-pair (front-deque deque))
            (set-front-ptr! deque new-pair)
            deque)))))

(define (rear-insert-deque! deque item)
  (let ((node (make-node item)))
    (let ((new-pair (cons node '())))
      (if (empty-deque? deque)
          (begin
            (set-front-ptr! deque new-pair)
            (set-rear-ptr! deque new-pair)
            deque)
          (begin
            (set-cdr! (rear-deque deque) new-pair)
            (set-node-ptr! (get-node-from-pair new-pair) (rear-deque deque))
            (set-rear-ptr! deque new-pair)
            deque)))))

(define (front-delete-deque! deque)
  (if (empty-deque? deque)
      (error "FRONT-DELETE-DEQUE! called with an empty deque" deque)
      (begin
        (let ((pair (cdr (front-deque deque))))
          (if (not (null? pair))
            (set-node-ptr! (get-node-from-pair pair) '()))
          (set-front-ptr! deque pair)
          deque))))

(define (rear-delete-deque! deque)
  (if (empty-deque? deque)
      (error "FRONT-DELETE-DEQUE! called with an empty deque" deque)
      (begin
        (let ((pair (get-node-pair (get-node-from-pair (rear-deque deque)))))
          (if (not (null? pair))
            (set-cdr! pair '()))
          (set-rear-ptr! deque pair)
          deque))))

(define (print-queue queue)
  (define (print-pair pair)
    (if (not (null? pair))
      (begin
        (display (car (car pair)))
        (print-pair (cdr pair)))))
  (print-pair (front-deque queue)))

(define q1 (make-deque))
(print-queue (front-insert-deque! q1 'a))
(newline)

(print-queue (front-insert-deque! q1 'b))
(newline)

(print-queue (rear-insert-deque! q1 'c))
(newline)

(print-queue (front-delete-deque! q1))
(newline)

(print-queue (rear-delete-deque! q1))
(newline)
