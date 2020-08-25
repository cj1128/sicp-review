(define (cont-frac-recursive n d k)
  (define (recur m)
    (if
      (= m k) (/ (n k) (d k))
      (/ (n m) (+ (d m) (recur (+ m 1))))))
  (recur 1))

(define (cont-frac-iterative n d k)
  (define (iterate m prev-value)
    (cond
      ((= m 0) prev-value)
      ((= m k) (iterate (- m 1) (/ (n k) (d k))))
      (else (iterate (- m 1) (/ (n m) (+ (d m) prev-value))))))
  (iterate k 0))
