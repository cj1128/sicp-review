; In expmod, the reduction steps in the cases where the exponent e is greater than 1
; are based on the fact that, for any integers x, y, and m,
; we can find the remainder of x times y modulo m by computing separately
; the remainders of x modulo m and y modulo m, multiplying these,
; and then taking the remainder of the result modulo m.

(define (fast-prime? n times)
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

  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

; wrong result, 6601 is not a prime, but it can fool the Fermat test
(display (fast-prime? 6601 10))
(newline)

(display (fast-prime? 9677 10))
