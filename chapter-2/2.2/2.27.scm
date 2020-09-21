(define (deep-reverse x)
  (cond
    ((null? x) '())
    ((pair? x)
     (append
       (deep-reverse (cdr x))
       (list (deep-reverse (car x)))))
    (else x)))

(display (deep-reverse '(1 2 3 4)))
(newline)

(display (deep-reverse '((1 2) (3 4))))
(newline)

(display (deep-reverse '((1 2 3 4))))
