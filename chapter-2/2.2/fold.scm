(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial
                      (cdr sequence)))))

;(define (fold-left op initial seq)
;  (define (iter result rest)
;    (if (null? rest)
;        result
;        (iter (op result (car rest))
;              (cdr rest))))
;  (iter initial seq))

; This is a simpler implementation than the one in the book
(define (fold-left op initial seq)
  (if (null? seq)
      initial
      (fold-left op (op initial (car seq)) (cdr seq))))
