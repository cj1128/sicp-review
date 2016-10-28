;; Exercise 4.16
;; Implements the method described for interpreting internal definitions

;; a
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (if (null? vars)
          (env-loop (enclosing-environment env))
          (if (eq? var (car vars))
            (if (eq? (car vals) '*unassigned*)
                (error "Unassigned variable" var)
                (car vals))
            (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame) (frame-values frame)))))
  (env-loop env))

;; b
(define (internal-defs body)
  (filter (lambda (def) (eq? (car def) 'define)) body))
(define (non-internal-defs body)
  (filter (lambda (def) (not (eq? (car def) 'define))) body))
(define (scan-out-defines body)
  (let ((defs (internal-defs body))
        (non-defs (non-internal-defs body)))
    (append
      (list 'let
        (map (lambda (def) (list (cadr def) '*unassigned*)) defs)
      (append
        (map (lambda (def) (list 'set! (cadr def) (caddr def)) defs))
        non-defs)))))

;; c
(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))
;; we should place scan-out-defines in make-procedure
;; so that it is only called once at the time the lambda
;; expression is first evaluated and not every time
;; a procedure is called
