;;Exercise 1.43

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated-f f n)
  (define (iterate g k)
    (if (= k n) g
        (iterate (compose f g) (+ k 1))))
  (iterate f 1))

(display ((repeated-f square 3) 5))
