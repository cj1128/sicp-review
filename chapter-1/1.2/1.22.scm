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

(define (search-for-primes n count)
  (if (> count 0)
      (let ((begin-time (real-time-clock)))
        (if (prime? n)
            (begin
              (display n)
              (display "***")
              (display (- (real-time-clock) begin-time))
              (newline)
              (search-for-primes (+ n 1) (- count 1)))
            (search-for-primes (+ n 1) count)))))

(search-for-primes 1e6 3)
(newline)

(search-for-primes 1e7 3)
(newline)

(search-for-primes 1e8 3)
(newline)

(search-for-primes 1e9 3)
(newline)
