(load "repeated.lib.scm")

(define (smooth f)
  (define dx 0.0000001)
  (define (average x y z) (/ (+ x y z) 3))
  (lambda (x)
    (average (f (- x dx)) (f x) (f (+ x dx)))))

(define (repeated-smooth f n)
  ((repeated smooth n) f))

(display ((repeated-smooth (lambda (x) (+ x 1)) 3) 10))
