;;Exercise 1.30
;;Rewrite sum so that it's performed iteratively
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (identity x) x)
(define (inc x) (+ x 1))

(display (sum identity 1 inc 1000))
