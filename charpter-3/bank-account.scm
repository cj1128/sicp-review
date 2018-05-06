(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin
          (set! balance (- balance amount))
          balance)
        "Insufficient funds!"))
  (define (deposit amount)
    (begin
      (set! balance (+ balance amount))
      balance))
  (define (dispatch m)
    (cond
      ((eq? m 'withdraw) withdraw)
      ((eq? m 'deposite) deposit)
      (else (error "Unknown request: MAKE-ACCOUNT" m))))
  dispatch)


(define acc (make-account 100))
(display ((acc 'withdraw) 50))
(newline)

(display ((acc 'withdraw) 80))
(newline)

(display ((acc 'deposite) 50))
(newline)

(display ((acc 'withdraw) 80))
(newline)
