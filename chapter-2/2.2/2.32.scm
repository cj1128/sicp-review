; The set of all subsets of a given set is the union of:
; - the set of all subsets excluding the first number.
; - the set of all subsets excluding the first number, with the first number re-inserted into each subset.
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map
                       (lambda (l)
                         (cons (car s) l))
                       rest)))))

(display (subsets '(1 2 3)))

