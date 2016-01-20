;; Exercise 3.18
;; Write a procedure that examines a list and determines whether it
;; contains a cycle that is whether a program which tried to find the end
;; of the list by taking successive cdrs would go into an infinite loop

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define (check-cycle l)
  (define visited '())
  (define (iter p)
    (if (not (pair? p))
        #f
        (begin
          (set! visited (cons p visited))
          (if (memq (cdr p) visited)
              #t
              (iter (cdr p))))))
  (iter l)
  )

(define a (make-cycle (list 'a 'b 'c)))
(define b '(1 2 3 4 5))
(display (check-cycle a))
(newline)

(display (check-cycle b))
(newline)
