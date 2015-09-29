;;Using Euclid's Algorithm to computer GCD

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


(display (gcd 3 8))
