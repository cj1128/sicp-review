;; 3.5.4

(load "utils.scm")
(load "delayed-integral.scm")

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

(display (stream-ref
           (solve (lambda (x) x) 1 0.001)
            1000))
