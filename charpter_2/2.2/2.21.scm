;; Exercise

(define (map proc list)
  (if (null? list)
      '()
      (cons (proc (car list))
            (map proc (cdr list)))))

(define (squre x)
  (* x x))

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items))
            (square-list (cdr items)))))

(define (square-list items)
  (map square items))

(display (square-list (list 1 2 3 4)))
