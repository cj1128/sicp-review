(define (fast-prime? n times)
  (define (expomod base exp m)
    (cond
      ((= exp 0) 1)
      ((even? exp)
       (remainder
         (square (expomod base (/ exp 2) m))
         m))
      (else
        (remainder
          (* base (expomod base (- exp 1) m))
          m))))

  (define (fermat-test n)
    (define (try-it a)
      (= (expomod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

  (cond ((= times 0) true)
    ((fermat-test n) (fast-prime? n (- times 1)))
    (else false)))

(define (search-for-primes n count)
  (if (> count 0)
    (let ((begin-time (real-time-clock)))
      ; How many times should we perform?
      ; Let's just pick 100
      (if (fast-prime? n 100)
        (begin
          (display n)
          (display "***")
          (display (- (real-time-clock) begin-time))
          (newline)
          (search-for-primes (+ n 1) (- count 1)))
        (search-for-primes (+ n 1) count)))))

(search-for-primes (floor->exact 1e20) 3)
(newline)

(search-for-primes (floor->exact 1e40) 3)
(newline)

(search-for-primes (floor->exact 1e80) 3)
(newline)
