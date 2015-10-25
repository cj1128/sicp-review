;; Exercise 1.44

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated-f f n)
  (define (iterate g k)
    (if (= k n) g
        (iterate (compose f g) (+ k 1))))
  (iterate f 1))

(define dx 0.0000001)
(define (smooth f)
  (lambda (x)
    (average (f (- x dx)) (f x) (f (+ x dx)))))

(define (repeated-smooth f n)
  (repeated-f smooth n))
