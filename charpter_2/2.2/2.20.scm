;; Exercise 2.20

(define (same-parity . a)
  (define (keep-number predicate l)
    (cond
     ((null? l) l)
     ((predicate (car l))
      (append (list (car l)) (keep-number predicate (cdr l))))
     (else (keep-number predicate (cdr l)))))

  (if (even? (car a)) (keep-number even? a)
      (keep-number odd? a)))

(display (same-parity  2 3 4 5 6 7))
(newline)
(display (same-parity  1 2 3 4 5 6 7))
