;;This is recursive
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

;;This is iterative
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b) result (iter (next a) (* (term a) result))))
  (iter a 1))

(define(identity x) x)
(define (inc x) (+ 1 x))

(define (factorial n)
  (product-iter identity 1 inc n))

(define (approximation-pi n)
  (define (term n)
    (define numerator (* n 2.0))
    (define denominator (+ 1.0 (* 2 n)))
    (*
     (/ numerator denominator)
     (/ (+ 2 numerator) denominator)))
  (*
   4
   (product-iter term 1 inc n)))

;;This is iterative

(display (factorial 10))
(display "\n")
(display (approximation-pi 100))
