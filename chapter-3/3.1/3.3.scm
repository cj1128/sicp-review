;; Exercise 3.3
;; Modify the make-account procedure so that it creates
;; password-protected accounts.

(define (make-account balance password)
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
  (define (dispatch p m)
    (if (eq? password p)
      (cond
        ((eq? m 'withdraw) withdraw)
        ((eq? m 'deposite) deposit)
        (else (error "Unknown request: MAKE-ACCOUNT" m)))
      (lambda (_)
        "Incorrect Password!")))
  dispatch)


(define acc (make-account 100 'cj))
(display ((acc 'cj 'withdraw) 50))
(newline)

(display ((acc 'error 'withdraw) 80))
(newline)

(display ((acc 'cj 'deposite) 50))
(newline)

(display ((acc 'cj 'withdraw) 80))
(newline)
