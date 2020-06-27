;; Exercise 3.22
;; Implements queue as a procedure

(define (make-queue)
  (let
    ((front-ptr '())
     (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (if (empty-queue?)
          (begin
            (set! front-ptr new-pair)
            (set! rear-ptr new-pair)
            dispatch)
          (begin
            (set-cdr! rear-ptr new-pair)
            (set! rear-ptr new-pair)
            dispatch))))
    (define (delete-queue!)
      (if (empty-queue?)
          (error "DELETE called with an empty queue" queue)
          (begin
            (set! front-ptr (cdr front-ptr))
            dispatch)))
    (define (print-pair pair)
      (if (not (null? pair))
        (begin
          (display (car pair))
          (print-pair (cdr pair)))))
    (define (print-queue)
      (print-pair front-ptr))
    (define (dispatch m)
      (cond
        ((eq? m 'front-ptr) front-ptr)
        ((eq? m 'rear-ptr) rear-ptr)
        ((eq? m 'empty-queue?) (empty-queue?))
        ((eq? m 'insert-queue!) insert-queue!)
        ((eq? m 'delete-queue!) (delete-queue!))
        ((eq? m 'print) (print-queue))
      ))
    dispatch))

(define q (make-queue))
((q 'insert-queue!) 'a)
(q 'print)
(newline)

((q 'insert-queue!) 'b)
(q 'print)
(newline)

(q 'delete-queue!)
(q 'print)
(newline)

(q 'delete-queue!)
(q 'print)
(newline)
