;; Exercise 4.3
;; rewrite eval so that the dispatch is done in
;; data-directed style

(define (eval exp env)
  (cond
    ((self-evaluating? exp) exp)
    ((variable? exp) (lookup-variable-value exp env))
    (else (let ((proc (get (car exp))))
            (if proc
                (proc exp env)
                (error "Unknown expression type: EVAL" exp))))))

(define (install-quoted)
  (define (eval-quoted exp env)
    (cadr exp))
  (put 'quote eval-quoted))

(define (install-assignment)
  (define (eval-assignment exp env)
    )
  (put 'set! eval-assignment))

(define (install-definition)
  (define (eval-definition exp env)
    )
  (put 'define eval-definition))

(define (install-if)
  (define (eval-if exp env)
    )
  (put 'if eval-if))

(define (install-lambda)
  (define (eval-lambda exp env)
    )
  (put 'lambda eval-lambda))

;; ...etc
