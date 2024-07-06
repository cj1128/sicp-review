(define (filtered-accumulate combiner null-value term a next b filter)
  (if (or (> a b))
      null-value
      (combiner
        (if (filter a) (term a) null-value)
        (filtered-accumulate combiner null-value term (next a) next b filter))))

(define (problem-a a b)
  ; Copied from chapter-1/1.2/prime.scm
  (define (prime? n)
    (define (smallest-divisor n) (find-divisor n 2))

    (define (find-divisor n test)
      (cond
        ((> (square test) n) n)
        ((divides? test n) test)
        (else (find-divisor n (+ test 1)))))

    (define (divides? a b) (= (remainder b a) 0))

    (= n (smallest-divisor n)))

  (define (inc x) (+ x 1))

  (define (sum-square-prime a b)
    (filtered-accumulate + 0 square a inc b prime?))

  (sum-square-prime a b))

; 2, 3, 5, 7, result should be 87
(display (problem-a 2 10))
(newline)

(define (problem-b n)
  (define (identity x) x)

  (define (inc x) (+ x 1))

  (define (product-relative-prime n)
    (define (relative-prime? x)
      (= (gcd x n) 1))
    (filtered-accumulate * 1 identity 1 inc n relative-prime?))

  (product-relative-prime n))

; 1, 3, 7, 9, result should be 189
(display (problem-b 10))
