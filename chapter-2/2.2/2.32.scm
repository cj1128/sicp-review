;; Exercise 2.32
;; Generates a set of subsets of a set

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map
                      (lambda (l)
                        (cons (car s) l))
                      rest)))))

(display (subsets '(1 2 3)))

