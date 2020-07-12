; (cc amount kind-of-coins)
; if amount is 0, we should count that as 1 way to make change
; if amount is less than 0, we should count that as 0 ways to make change
; if kind-of-coins is 0, we should count that as 0 ways to make change

(define (cc amount kind-of-coins)
  ; 50, 25, 10, 5, 1
  (define (first-denomination k)
    (cond
      ((= k 5) 50)
      ((= k 4) 25)
      ((= k 3) 10)
      ((= k 2) 5)
      ((= k 1) 1)))
  (cond
    ((= amount 0) 1)
    ((< amount 0) 0)
    ((= kind-of-coins 0) 0)
    (else (+
            (cc amount (- kind-of-coins 1))
            (cc (- amount (first-denomination kind-of-coins)) kind-of-coins)))))

(define (count-change amount) (cc amount 5))

(display (count-change 60))
(newline)
