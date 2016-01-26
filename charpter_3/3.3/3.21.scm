;; Exercise 3.21
;; Define a procedure print-queue that takes a queue
;; as input and prints the sequence of items in the queue

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item)
  (set-car! queue item))
(define (set-rear-ptr! queue item)
  (set-cdr! queue item))
(define (empty-queue? queue)
  (null? (front-ptr queue)))

(define (make-queue)
  (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
            (set-cdr! (rear-ptr queue) new-pair)
            (set-rear-ptr! queue new-pair)
            queue))))

(define (delete-queue! queue)
  (cond
    ((empty-queue? queue)
     (error "DELETE called with an empty queue" queue))
    (else
      (set-front-ptr! queue (cdr (front-ptr queue)))
        queue)))

;(define q1 (make-queue))
;(display (insert-queue! q1 'a))
;(newline)

;(display (insert-queue! q1 'b))
;(newline)

;(display (delete-queue! q1))
;(newline)

;(display (delete-queue! q1))
;(newline)


(define (print-queue queue)
  (define (print-pair pair)
    (if (not (null? pair))
      (begin
        (display (car pair))
        (print-pair (cdr pair)))))
  (print-pair (front-ptr queue)))

(define q1 (make-queue))
(print-queue (insert-queue! q1 'a))
(newline)

(print-queue (insert-queue! q1 'b))
(newline)

(print-queue (delete-queue! q1))
(newline)

(print-queue (delete-queue! q1))
(newline)
