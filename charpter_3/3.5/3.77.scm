;; Exercise 3.77
;; modify the procedure so that it expects the integrand as a delayed argument

(define (integral delayed-integrand initial-value dt)
  (cons-stream
    initial-value
    (let ((integrand (force delayed-integrand)))
      (if (stream-null? integrand)
          the-empty-stream
          (integral
            (delay (stream-cdr integrand))
            (+ (* dt (stream-car integrand))
               initial-value)
            dt)))))
