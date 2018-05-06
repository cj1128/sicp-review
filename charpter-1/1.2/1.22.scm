;;Exercise 1.22

(define (squrare n)
  (* n n))



(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test)
    (cond
     ((> (* test test) n) n)
     ((divide? test n) test)
     (else (find-divisor n (+ 1 test)))))
  (define (divide? test n)
    (= (remainder n test) 0))
  (if (= (smallest-divisor n) n) true false))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time)) false))

(define (report-prime elapsed-time)
  (display "***")
  (display elapsed-time))

(define (search-for-primes start count)
  (cond
   ((= count 0))
   ((timed-prime-test start) (search-for-primes (+ 1 start) (- count 1)))
   (else (search-for-primes (+ 1 start) count))))

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 10000 3)
