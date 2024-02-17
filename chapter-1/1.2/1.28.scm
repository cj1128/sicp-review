(define (checked-square x m)
  (if (and
        (= (remainder (square x) m) 1)
        (not (or (= x 1) (= x (- m 1)))))
      0
      (square x)))

(define (expmod base exp m)
  (cond
    ((= exp 0) 1)
    ((even? exp)
     (remainder (checked-square (expmod base (/ exp 2) m) m) m))
    (else
      (remainder
        (* base (expmod base (- exp 1) m))
        m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 2 (random (- n 2)))))

(define (fast-prime? n times)
  (cond
    ((= times 0) true)
    ((miller-rabin-test n) (fast-prime? n (- times 1)))
    (else false)))

; real prime
(display (fast-prime? 7919 10))
(newline)

; Carmichael numbers: 561, 1105, 1729, 2465, 2821, 6601
(display (fast-prime? 561 10))
(newline)

(display (fast-prime? 1105 10))
(newline)

(display (fast-prime? 1729 10))
(newline)

(display (fast-prime? 2465 10))
(newline)

(display (fast-prime? 2821 10))
(newline)

(display (fast-prime? 6601 10))
(newline)
