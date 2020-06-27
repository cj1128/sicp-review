(define (square x) (* x x))

(define (square-sum x y)
  (+ (square x) (square y)))

(define (f x y z)
  (cond
    ((and (<= x y) (<= x z)) (square-sum y z))
    ((and (<= y x) (<= y z)) (square-sum x z))
    ((and (<= z x) (<= z y)) (square-sum x y))))

(display (f 1 2 3))
(newline)

(display (f 3 2 1))
(newline)

(display (f 3 1 2))
