; r: row, i: index, both are 1-based
(define (f r i)
  (cond
    ((or (= r 1) (= r 2)) 1)
    ((or (= i 1) (= i r)) 1)
    (else (+
            (f (- r 1) i)
            (f (- r 1) (- i 1))))))

(display (f 5 1))
(newline)

(display (f 5 2))
(newline)

(display (f 5 3))
(newline)

(display (f 5 4))
(newline)

(display (f 5 5))
(newline)
