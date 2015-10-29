;; Exercise 2.25

(define l1 (list 1 3 (list 5 7) 9))
(define l2 (list (list 7)))
(define l3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

(display (car (cdr (car (cdr (cdr l1))))))
(newline)

(display (car (car l2)))
(newline)

;; This is too complicated
(display (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr l3)))))))))))))
