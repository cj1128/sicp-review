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
              (search-for-primes (+ n 2) (- count 1)))
            (search-for-primes (+ n 1) count)))))

(search-for-primes 1e6 3)
(newline)

(search-for-primes 1e7 3)
(newline)

(search-for-primes 1e8 3)
(newline)

(search-for-primes 1e9 3)
(newline)

### 1.23

{empty}::
+
--

link:chapter-1/1.2/1.23.scm[] is almost identical to 1.22.scm.

----
1000003.***1
1000033.***1
1000037.***1

10000019.***3
10000079.***3
10000103.***3

100000007.***10
100000037.***8
100000039.***8

1000000007.***24
1000000009.***25
1000000021.***24
----

We can see that the process runs basically twice as fast as exercise 1.22, so the expectation is confirmed.

--
