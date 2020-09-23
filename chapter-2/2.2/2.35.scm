(load "accumulate.scm")

(define (count-leaves tree)
  (accumulate +
              0
              (map
                (lambda (sub-tree)
                  (if (pair? sub-tree)
                      (count-leaves sub-tree)
                      1))
                tree)))

(define t '(((1 2) 3) 4 (5 6)))

(display (count-leaves t))



