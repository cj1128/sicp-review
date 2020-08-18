; Recursive
(define (product term a next b)
  (if (> a b)
      1
      (* (term a) (product term (next a) next b))))

(define(identity x) x)
(define (inc x) (+ 1 x))

(define (factorial n)
  (product identity 1 inc n))

(define (approximation-pi n)
  (define (term n)
    (define numerator (* n 2.0))
    (define denominator (+ 1.0 (* 2 n)))
    (*
      (/ numerator denominator)
      (/ (+ 2 numerator) denominator)))
  (*
    4
    (product term 1 inc n)))

(display (factorial 10))
(newline)

(display (approximation-pi 100))
