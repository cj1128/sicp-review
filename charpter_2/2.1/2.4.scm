;; Exercise 2.4

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))
(define (cdr z)
  (z (lambda (p q) q)))

(display (car (cons 1 2)))
(newline)
(display (cdr (cons 1 2)))
