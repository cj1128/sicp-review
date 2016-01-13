;;Exercise 1.12
;;Computer the value of row r and index i of Pascal's Triangle, 1 based
(define (f r i)
  (cond
    ((or (= r 1) (= r 2)) 1)
    ((or (= i 1) (= i r)) 1)
    (else (+
      (f (- r 1) i)
      (f (- r 1) (- i 1))))))

(display (f 5 1))
(display "\n")
(display (f 5 2))
(display "\n")
(display (f 5 3))
(display "\n")
(display (f 5 4))
(display "\n")
(display (f 5 5))
