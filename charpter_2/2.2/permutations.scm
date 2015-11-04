;; Example of "Nesting Mapping"
;; Get permutations of a set

(define (flatmap proc seq)
  (fold-right append '() (map proc seq)))

(define (permutations s)
  (if (null? s)
      (list '())
      (flatmap (lambda (x)
                 (map (lambda (p)
                        (cons x p))
                      (permutations (remove x s))))
               s)))

(define (remove item seq)
  (filter (lambda (x) (not (= x item)))
          seq))

(display (permutations '(1)))
