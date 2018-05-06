(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (cube n) (* n n n))
(define (identity n) n)

(define (sum-cubes a b)
  (sum cube a inc b))

(define (ordinary-sum a b)
  (sum identity a inc b))

(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(display (sum-cubes 1 10))
(display "\n")
(display (ordinary-sum 1 10))
(display "\n")
(display (* 8 (pi-sum 1 10000)))
(display "\n")
(display (integral cube 0 1 0.01))


