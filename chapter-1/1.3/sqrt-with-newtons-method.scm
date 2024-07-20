(load "newtons-method.lib.scm")

(define (sqrt x)
  (newtons-method
    (lambda (y) (- (square y) x)) 1.0))

(display (sqrt 40))
