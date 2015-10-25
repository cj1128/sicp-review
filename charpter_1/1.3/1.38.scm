;; Exercise 1.38

(define (cont-frac-iterative n d k)
  (define (iterate m prev-value)
    (cond
     ((= m 1) (/ (n 1) (+ (d 1) prev-value)))
     ((= m k) (iterate (- m 1) (/ (n k) (d k))))
     (else (iterate (- m 1) (/ (n m) (+ (d m) prev-value))))))
  (iterate k 0))

(define (d i)
  (cond
   ((= i 1) 1)
   ((= i 2) 2)
   ((= 0 (remainder (- i 2) 3)) (* 2 (/ (+ i 1) 3)))
   (else 1)))

(display (cont-frac-iterative (lambda (i) 1.0) d 20))
