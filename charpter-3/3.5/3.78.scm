;; Exercise 3.78
;; write a procedure solve-2nd that takes as arguments the constants
;; a, b and dt and the initial values y0 and dy0 for y and dy/dt and
;; generates the stream of successive values of y

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream
      initial-value
      (let ((integrand (force delayed-integrand)))
        (stream-add (stream-scale integrand dt) int))))
  int)

(define (solve-2nd a b dt y0 dy0)
  (define y
    (integral (delay dy) y0 dt))
  (define dy
    (integral (delay ddy)
              dy0
              dt))
  (define ddy
    (stream-add
      (stream-scale dy a)
      (sttream-scale y b))))
