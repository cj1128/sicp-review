;; Exercise 2.2

;; We can use substitue method to verify that the procedure will
;; generate a list of reverse oreder


;; we should notice that (cons list item) will not generate a
;; list, but a pair

;; This is the correct version of iterative square-list

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (append answer
               (list (square (car things)))
                            ))))
  (iter items '()))

(display (square-list (list 1 2 3 4)))
