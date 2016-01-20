;; Exercise 3.19
;; Redo exercise 3.18 using an algorithm that takes only
;; a constant amount of space
;; This requires a very clever idea
;; We need to use "Tortoise and hare" algorithm

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define (check-cycle l)
  (define (iter tortoise hare)
    (cond
      ((not (pair? tortoise)) #f)
      ((not (pair? hare)) #f)
      ((eq? tortoise hare) #t)
      ((not (pair? (cdr hare))) #f)
      (else (iter (cdr tortoise) (cdr (cdr hare))))
       ))
  (iter l (cdr l))
  )

(define a (make-cycle (list 'a 'b 'c)))
(define b '(1 2 3 4 5))
(display (check-cycle a))
(newline)

(display (check-cycle b))
(newline)
