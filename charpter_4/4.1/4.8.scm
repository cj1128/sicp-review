;; Modify let->combination to support named let
;; (let <name> ((var1 value1) (var2 value2)) <body1> <body2>)
;; we define a function and put it in a lambda
;((lambda ()
;  (define (name var1 var2)
;    <body1> <body2>)
;  (name <value1> <value2>)))

(define (named-let? exp) (and (let? exp) (symbol? (cadr exp))))
(define (named-let-function-name exp) (cadr exp))
(define (named-let-function-params exp) (map car (caddr exp)))
(define (named-let-function-values exp) (map cadr (caddr exp)))
(define (named-let->function exp)
  (cons 'define
        (cons (cons (named-let-function-name exp) (named-let-function-params exp))
          (cdddr exp))))

(define (named-let->combination exp)
  (list (make-lambda '() (list
    (named-let->function exp)
    (cons (named-let-function-name exp) (named-let-function-values exp))
  ))))

(define (let->combination exp)
  (if (named-let? exp)
      (named-let->combination exp)
      (cons (make-lambda
              (let-vars exp)
              (let-body exp))
            (let-exps exp))))
