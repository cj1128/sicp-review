;; definition of apply
(define (m-apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-paramaters procedure)
             arguments
             (procedure-environment procedure))))
        (else
          (error "Unknown procedure type: APPLY" procedure))))

(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-paramaters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))

;; environment operations
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (frame-variables frame)))
  (set-cdr! frame (cons val (frame-values frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals)
            base-env)
      (if (< (length vars) (length vals))
          (error "Variables are less than values")
          (error "Values are less than variables"))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (if (null? vars)
          (env-loop (enclosing-environment env))
          (if (eq? var (car vars))
              (car vals)
              (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame) (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (if (null? vars)
          (env-loop (enclosing-environment env))
          (if (eq? var (car vars)) (set-car! vals val)
              (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables) (frame-values)))))
  (env-loop env))

;; To define a variable, we search the first frame for a binding for the
;; variable, and change the binding if it exists.
;; If no such binding exists, we adjoin one to the first frame
(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (if (null? vars)
          (add-binding-to-frame! var val frame)
          (if (eq? var (car vars))
              (set-car! vals val)
              (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame) (frame-values frame))))

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
(define (primitive-implementation proc) (cdr proc))

(define primitive-procedures
  (list (cons 'car car)
        (cons 'cdr cdr)
        (cons 'cons cons)
        (cons 'null? null?)
        (cons 'map map)
        ))
(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc) (cons 'primitive (cdr proc)))
       primitive-procedures))

(define (setup-environment)
  (let ((initial-env
          (extend-environment (primitive-procedure-names)
                              (primitive-procedure-objects)
                              the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

(define (apply-primitive-procedure proc args)
  (apply
    (primitive-implementation proc) args))

