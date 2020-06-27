;; Exercise 2.35;
;; Redifine count-leaves using accumulate

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial
                      (cdr sequence)))))

(define (enumerate-tree t)
  (cond
   ((null? t) '())
   ((pair? t)
    (append (enumerate-tree (car t))
            (enumerate-tree (cdr t))))
   ((list t))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1)
                       (enumerate-tree t))))

(define t '(((1 2) 3) 4 (5 6)))

(display (count-leaves t))



