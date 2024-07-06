(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
      (sum term (next a) next b))))

; compute integral of function f
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (*
    (sum f (+ a (/ dx 2.0)) add-dx b)
    dx))

(define (cube x) (* x x x))

(display (integral cube 0 1 0.01))
; .24998750000000042

(newline)
(display (integral cube 0 1 0.001))
; .249999875000001

; exact value of the integral of cube between 0 and 1 is 1/4.
