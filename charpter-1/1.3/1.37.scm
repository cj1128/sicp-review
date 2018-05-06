;;Exercise 1.37-1
;; φ = 1.618033
;; 1/φ = 0.618033

(define (cont-frac-recursive n d k)
  (define (recur m)
    (if
     (= m k) (/ (n k) (d k))
     (/ (n m) (+ (d m) (recur (+ m 1))))))
  (recur 1))


(define (cont-frac-iterative n d k)
  (define (iterate m prev-value)
    (cond
     ((= m 1) (/ (n 1) (+ (d 1) prev-value)))
     ((= m k) (iterate (- m 1) (/ (n k) (d k))))
     (else (iterate (- m 1) (/ (n m) (+ (d m) prev-value))))))
  (iterate k 0))

;; k = 11 is enough to be accurate to 4 decimal places
(display "recursive:\n")
(display (cont-frac-recursive (lambda (i) 1.0)
           (lambda (i) 1.0) 11))

(newline)

(display "iterative:\n")
(display (cont-frac-iterative (lambda (i) 1.0)
                              (lambda (i) 1.0) 11))
