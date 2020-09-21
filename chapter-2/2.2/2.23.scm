(define (for-each proc items)
  (if (null? items)
      true
      (begin
        (proc (car items))
        (for-each proc (cdr items)))))

(for-each
  (lambda (x) (display x) (newline))
  (list 1 2 3 4))
