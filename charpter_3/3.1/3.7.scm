;; Exercise 3.7
;; Define a procedure make-joint that accomplishes to make joint accounts

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

(define (make-joint acc passwd new-passwd)
  (lambda (p)
    (if (eq? p new-passwd)
        (lambda (op)
          (acc passwd op))
        "Incorrect Password!")))


(define acc (make-account 100 'cj))
(define acc2 (make-joint acc 'cj 'abc))

(display ((acc 'cj 'withdraw) 50))
(newline)

(display (((acc2 'abc) 'withdraw) 20))
(newline)

