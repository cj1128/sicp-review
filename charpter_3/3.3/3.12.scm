;; Exercise 3.12

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
(display z)
(newline)

(display (cdr x)) ;; (b)
(newline)

(define w (append! x y))
(display w)
(newline)

(display (cdr x)) ;; (b c d)
(newline)
