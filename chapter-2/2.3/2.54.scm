(define (equal? l1 l2)
  (cond
    ((and
       (null? l1) (null? l2))
     true)
    ((and
       (pair? l1) (pair? l2))
     (if (eq? (car l1) (car l2))
         (equal? (cdr l1) (cdr l2))
         false))
    (else
      (eq? l1 l2))))

(display (equal? 'a 'a))
(newline)

(display (equal? (cons 1 2) (cons 1 2)))
(newline)

(display (equal? (cons 1 2) (cons 2 1)))
(newline)

(display (equal? '(a b c) '(a b c)))
(newline)

(display (equal? '(a b c) '(c d e)))
