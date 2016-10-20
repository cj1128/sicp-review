;; Exercise 4.12
;; Define abstractions that capture the common patterns between set-variable-value!,
;; define-variable! and lookup-variable-value and redefine these procedures
;; in terms of these abstractions

;; we use original representation of frame

;; use this method to iterate env, received two params:
;; env and next
;; env is a env list and next is a proc
(define (iterate-env env proc)
  (proc env (lambda () (iterate-env (cdr env) proc))))

(define (find-frame-var frame var match-proc non-match-proc)
  (define (scan vars vals)
    (if (null? vars)
        (non-match-proc)
        (if (eq? (car vars) var)
            (match-proc vals)
            (scan (cdr vars) (cdr vals)))))
  (scan (frame-variables frame) (frame-values frmae)))


(define (lookup-variable-value var env)
  (iterate-env env (lambda (env next)
                     (if (eq? env the-empty-environment)
                         (error "Unbound variable" var)
                         (find-frame-var (first-frame env) var
                                         (lambda (vals) (car vals))
                                         next)))))

(define (set-variable-value! var val env)
  (iterate-env env (lambda (env next)
                     (if (eq? env the-empty-environment)
                         (error "Unbound variable: SET!" var)
                         (find-frame-var (first-frame env) var
                                         (lambda (vars)
                                           (set-car! vals val))
                                         next)))))

(define (define-variable! var val env)
  (find-frame-var (first-frame env)
                  (lambda (vals)
                    (set-car! vals val))
                  (lambda ()
                    add-binding-to-frame! var val env)))
