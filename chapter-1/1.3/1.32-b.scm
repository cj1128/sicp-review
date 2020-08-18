; Iterative
(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (sum term a next b)
  (accumulate-iter + 0 term a next b))

(define (product term a next b)
  (accumulate-iter * 1 term a next b))

(define (identity x) x)
(define (inc x) (+ 1 x))

(display (sum identity 1 inc 100))
(newline)

(display (product identity 1 inc 10))
