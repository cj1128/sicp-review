; recursive
(define (product-recur term a next b)
  (if (> a b)
      1
      (* (term a) (product-recur term (next a) next b))))

; iterative
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b) result (iter (next a) (* (term a) result))))
  (iter a 1))

(define (identity x) x)
(define (inc x) (+ 1 x))

(define (factorial n)
  (product-recur identity 1 inc n))

; n=1, 2/3
; n=2, (2*4)/(3*3)
; n=3, (2*4*4)/(3*3*5)
(define (approximation-pi prod n)
  (define (term n)
    (define a (+ n 1.0))
    (define b (+ n 2.0))
    (if (even? n) (/ b a) (/ a b)))
  (*
    4
    (prod term 1 inc n)))

; 3628800
(display (factorial 10))
(newline)

(display (approximation-pi product-recur 200))
(newline)

(display (approximation-pi product-iter 200))
