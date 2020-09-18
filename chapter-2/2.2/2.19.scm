(define us-coins (list 50 25 10 5 1))

(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
  (cond
    ((= amount 0) 1)
    ((or (< amount 0) (no-more? coin-values)) 0)
    (else
      (+
        (cc amount (except-first-denomination coin-values))
        (cc (- amount (first-denomination coin-values)) coin-values)))))

(define first-denomination car)

(define except-first-denomination cdr)

(define (no-more? values) (<= (length values) 0))

(define (timed l)
  (let ((s (real-time-clock)))
    (l)
    (newline)
    (display (- (real-time-clock) s))))

; The order of the coins does not affect the result.
; Becuase the procedure computes all possible combinations.
(display (cc 100 us-coins))
(newline)

(display (cc 100 (reverse us-coins)))
(newline)

; This is very slow! takes appromately 10s in my computer.
;(display (cc 100 uk-coins))
;(newline)

