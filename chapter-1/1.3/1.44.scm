(load "repeated.scm")

(define (average x y z) (/ (+ x y z) 3))

(define dx 0.0000001)
(define (smooth f)
  (lambda (x)
    (average (f (- x dx)) (f x) (f (+ x dx)))))

(define (repeated-smooth f n)
  ((repeated smooth n) f))

(display ((repeated-smooth (lambda (x) (+ x 1)) 3) 10))
