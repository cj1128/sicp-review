;; Exercise 3.30
;; Write a procedure ripple-carry-adder that generates
;; the corresponding circuit

;; full-adder delay: 2 half-adder-delay + or-gate-delay
;; half-adder-delay: max(and-gate-delay + inverter, or-gate-delay) + and-gate-delay
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire)) (c1 (make-wire)) (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

(define (ripple-carry-adder a b s c)
  (let ((c-in (make-wire)))
    (if (null? (cdr a))
      (set-signal! c-in 0)
      (ripple-carry-adder (cdr a) (cdr b) (cdr s) c-in))
    (full-adder (car a) (car b) c-in (car s) c)))

;; n bit ripple-carry-delay: n full-adder-delay
;; 2n half-adder-delay + n or-gate-delay
;; 2n max(and-gate-delay + inverter-delay, or-gate-delay) + 2n and-gate-delay + n or-gate-delay





