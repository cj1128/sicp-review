(load "fold.scm")

(define (test) (display (reverse '(1 2 3 4))))

(define (reverse seq)
  (fold-right
    (lambda (x y)
      (append y (list x)))
    '() seq))

(test)
(newline)

(define (reverse seq)
  (fold-left
    (lambda (x y)
      (cons y x))
    '()
    seq))

(test)
