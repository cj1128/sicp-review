(define (expt b n)
  (define (iter a b n)
    (cond
      ((= n 1) (* a b))
      ((even? n) (iter a (square b) (/ n 2)))
      (else (iter (* a b) (square b) (/ (- n 1) 2)))))
  (iter 1 b n))

(display (expt 2 20))
