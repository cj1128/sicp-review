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

(define (fermat-test num)
  (define (test k)
    (if (= k num) true
        (if (= (expmod k num num) k)
            (test (+ k 1))
            false)))
  (test 1))

; Carmichael numbers: 561, 1105, 1729, 2465, 2821, 6601

(display (fermat-test 561))
(newline)

(display (fermat-test 1105))
(newline)

(display (fermat-test 1729))
(newline)

(display (fermat-test 2465))
(newline)

(display (fermat-test 2821))
(newline)

(display (fermat-test 6601))
(newline)

