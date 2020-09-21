(define (fringe tree)
  (cond
    ((null? tree) '())
    ((pair? tree)
     (append
       (fringe (car tree))
       (fringe (cdr tree))))
    (else (list tree))))

(define x '((1 2) (3 4)))

(display (fringe x))
(newline)

(display (fringe (list x x)))


