;;Exercise 1.32
;;Write a more general noticion called accumulate which can implement sum and product

;;This is recursive
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))


;;This is iterative
(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))
(define (product term a next b)
  (accumulate-iter * 1 term a next b))

(define (identity x) x)
(define (inc x) (+ 1 x))

(display (sum identity 1 inc 100))
(display "\n")
(display (product identity 1 inc 10))
