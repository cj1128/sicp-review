;;Fermat test for prime number
;; expmod using these two theorems
;; theorem 1: a^2b % m = (a^b % m)^2 % m
;; theorem 2: A^(2b + 1) % m = ((a^2b % m) * a) % m

(define (even? n)
  (= (remainder n 2) 0))

(define (expmod base exp m)
  (cond
    ((= exp 0) 1)
    ((even? exp)
      (remainder
        (square (expmod base (/ exp 2) m))
        m))
    (else
      (remainder
        (* base (expmod base (- exp 1) m))
        m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond
    ((= times 0) true)
    ((fermat-test n) (fast-prime? n (- times 1)))
  (else false)))

(display (fast-prime? 8 10))
