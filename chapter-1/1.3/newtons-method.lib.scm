(load "fixed-point.lib.scm")

(define (deriv g)
  (define dx 0.00001)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x) (- x
                 (/ (g x)
                    ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g)
               guess))
