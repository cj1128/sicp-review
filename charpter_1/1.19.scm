;;Exercise 1.19
;;p' = p^2 + q^2
;;q' = q^2 + 2pq

(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (even? n)
  (= (remainder n 2) 0))

(define (fib-iter a b p q n)
  (cond
    ((= n 0) b)
    ((even? n)
      (fib-iter a b
        (+ (* p p) (* q q)) ;;P'
        (+ (* q q) (* 2 p q)) ;;Q'
        (/ n 2)))
    (else (fib-iter
      (+ (* b q) (* a q) (* a p))
      (+ (* b p) (* a q))
      p
      q
      (- n 1)))))

(display (fib 300))