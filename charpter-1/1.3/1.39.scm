;; Exercise 1.39
;; tan(10) = 0.64836

(define (cont-frac-iterative n d k)
  (define (iterate m prev-value)
    (cond
     ((= m 1) (/ (n 1) (+ (d 1) prev-value)))
     ((= m k) (iterate (- m 1) (/ (n k) (d k))))
     (else (iterate (- m 1) (/ (n m) (+ (d m) prev-value))))))
  (iterate k 0))

(define (tan-cf x k)
  (define (n i)
    (if (= i 1) x (- (* x x))))
  (define (d i)
    (- (* i 2) 1.0))
  (cont-frac-iterative n d k))

(display (tan-cf 10 20))
