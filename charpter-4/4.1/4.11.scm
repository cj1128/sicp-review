;; Exercise 4.11
;; We can represent a frame as a list of bindings,
;; wehre each binding is a name-value pair
;; rewrite the environment operations to use this alternative representation


(define (make-frame variables values)
  (if (null? variables)
      '()
      (cons (cons (car variables) (car values))
            (make-frame (cdr variables) (cdr values)))))
(define (add-binding-to-frame! var val frame)
  (append! frame (list (cons var val))))

;; we don't need these methods any more
;(define (frame-variables frame)
;  (map car frame))
;(define (frame-values frame)
;  (map cadr frame))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan bindings)
      (if (null? bindings)
          (env-loop (enclosing-environment env))
          (let ((binding (car bindings)))
            (if (eq? var (car binding))
                (cdr binding)
                (scan (cdr bindings))))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (scan (first-frame env))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan bindings)
      (if (null? bindings)
          (env-loop (enclosing-environment env))
          (let ((binding (car bindings)))
            (if (eq? var (car binding))
                (set-cdr! binding val)
                (scan (cdr bindings))))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (scan (first-frame env))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan bindings)
      (if (null? bindings)
        (add-binding-to-frame! var val frame)
        (let ((binding (car bindings)))
          (if (eq? var (car binding))
              (set-cdr! binding val)
              (scan (cdr bindings))))))
    (scan frame)))
