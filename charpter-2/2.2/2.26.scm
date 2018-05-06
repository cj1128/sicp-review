;; Exercise 2.26

(define x (list 1 2 3))
(define y (list 4 5 6))

(display (append x y)) ;;(1 2 3 4 5 6)
(newline)

(display (cons x y)) ;; ((1 2 3) (4 5 6))
(newline)

(display (list x y)) ;;((1 2 3) (4 5 6))
