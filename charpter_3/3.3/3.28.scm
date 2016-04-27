;; Exercise 3.28
;; Define an or-gate as a primitive function box


(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
        (lambda () (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

(define (logical-or i1 i2)
  (cond
    ((= i1 1) 1)
    ((= i2 1) 1)
    (else 0)))

