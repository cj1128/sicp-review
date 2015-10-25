;;Exercise 1.42

(define (inc x)
  (+ x 1))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(display ((compose square inc) 6))
