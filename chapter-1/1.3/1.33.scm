;;Erercise 1.33
;;Filtered Accumulate procedure

(define (filtered-accumulate combiner null-value term a next b filter)
  (if (or (> a b))
      null-value
      (combiner
       (if (filter a) (term a) null-value)
       (filtered-accumulate combiner null-value term (next a) next b filter))))

(define (even? x)
  (= (remainder x 2) 0))

(define (identity x) x)
(define (inc x) (+ x 1))
(define (square x) (* x x))

(define (even-sum a b)
  (filtered-accumulate + 0 identity a inc b even?))

;;Assuming we have prime? and gcd procedure, they are written in previous sections

(define (sum-square-prime a b)
  (filtered-accumulate + 0 square a inc b prime?))

(define (product-relative-prime n)
  (define (relative-prime? x)
    (= (gcd x n) 1))
  (filtered-accumulate * 1 identity 1 inc n relative-prime?))

(display (even-sum 1 100))
