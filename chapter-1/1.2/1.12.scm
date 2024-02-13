; r: row, i: index, both are 1-based
(define (f r i)
  (cond
    ((or (= r 1) (= r 2)) 1)
    ((or (= i 1) (= i r)) 1)
    (else (+
            (f (- r 1) i)
            (f (- r 1) (- i 1))))))

; row: 1-based
(define (print-row row)
  (define (iter cur)
    (if (<= cur row)
      (begin
        (display (f row cur))
        (display " ")
        (iter (+ cur 1)))))
  (iter 1))

(print-row 5)
