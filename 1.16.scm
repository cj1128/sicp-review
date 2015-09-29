;;Exercise 1.16
(define (square n) (* n n))
(define (even? n) (= (remainder n 2) 0))

(define (expn-iter a b n)
  (cond
    ((= n 1) (* a b))
    ((even? n) (expn-iter a (square b) (/ n 2)))
    (else (expn-iter (* a b) (square b) (/ (- n 1) 2)))))

(define (expn b n)
  (expn-iter 1 b n))

(display (expn 2 100))
