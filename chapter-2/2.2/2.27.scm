;; Exercise 2.27

;; Add something to a list
(define (add-to-list l item)
  (append l (list item)))

(define (deep-reverse x)
  (cond
   ((null? x) '())
   ((pair? x)
    (add-to-list
     (deep-reverse (cdr x))
     (deep-reverse (car x))))
   (else x)))

(display (deep-reverse '(1 2 3 4)))
(newline)

(display (deep-reverse '((1 2) (3 4))))
(newline)

(display (deep-reverse '((1 2 3 4))))
