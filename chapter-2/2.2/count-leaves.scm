(define (count-leaves x)
  (cond
    ((null? x) 0)
    ((pair? x)
     (+
       (count-leaves (car x))
       (count-leaves (cdr x))))
    (else 1)))

