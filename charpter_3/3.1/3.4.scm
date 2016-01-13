;; Exercise 3.4
;; Modify the procedure make-account of Exercise 3.3,
;; if an account is accessed more than seven consecutive times
;; with an incorrect password, it invokes the procedure call-the-cops

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
  (define (call-the-cops)
    (display "We have called the cops!")
    (lambda (_) "Incorrect Password!"))
  (let ((incorrect-counter 0))
    (define (dispatch p m)
      (if (eq? password p)
        (begin
          (set! incorrect-counter 0)
          (cond
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposite) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT" m))))
        (begin
          (set! incorrect-counter (+ incorrect-counter 1))
          (if (> incorrect-counter 7)
            (call-the-cops)
          (lambda (_)
            "Incorrect Password!")))))
    dispatch))


(define acc (make-account 100 'cj))
((acc 'wrong 'withdraw) 20)
((acc 'wrong 'withdraw) 20)
((acc 'wrong 'withdraw) 20)
((acc 'wrong 'withdraw) 20)
((acc 'wrong 'withdraw) 20)
((acc 'wrong 'withdraw) 20)
((acc 'wrong 'withdraw) 20)
((acc 'wrong 'withdraw) 20)

(newline)
(display ((acc 'cj 'withdraw) 20))
(display ((acc 'wrong 'withdraw) 20))
