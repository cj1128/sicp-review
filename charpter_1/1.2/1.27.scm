;;Erercise 1.27, Carmichael numbers, which do fool the fermat test
;;561, 1105, 1729, 2465, 2821, 6601

(define (fast-prime? n times)
  (define (even? p)
    (= (remainder p 2) 0))
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
  (define (fermat-test)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))
  (cond
   ((= times 0) true)
   ((fermat-test) (fast-prime? n (- times 1)))
   (else false)))

(define (normal-prime? n)
  (define (smallest-divisor p)
    (find-divisor n 2))

  (define (squrare n)
    (* n n))

  (define (divide? test)
    (= (remainder n test) 0))

  (define (find-divisor test)
    (cond
     ((> (square test) n) n)
     ((divide? test) test)
     (else (find-divisor (+ 1 test)))))
  (if (= (find-divisor 2) n) true false))

(display (fast-prime? 561 100))
(newline)
(display (normal-prime? 561))
(newline)

(display (fast-prime? 1729 100))
(newline)
(display (normal-prime? 1729))
(newline)

(display (fast-prime? 2465 100))
(newline)
(display (normal-prime? 2465))
(newline)

(display (fast-prime? 2821 100))
(newline)
(display (normal-prime? 2821))
(newline)

(display (fast-prime? 6601 100))
(newline)
(display (normal-prime? 6601))
