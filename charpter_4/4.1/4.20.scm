;; Exercise 4.20

;; (letrec ((<var1> <exp1>) (<var2> <exp2>))
;;   <body>)

;; (let ((<var1> '*unassigned*) (<var2> '*unassigned*))
;;   (set! <var1> <exp1>)
;;   (set! <var2> <exp2>)
;;   <body)

;; a
;; Implement letrec as a derived expression, by transforming a letrec expression
;; into a let expression as shown in the text
(define (letrec->let exp)
  (let ((defs (cadr exp)) (body (cddr exp)))
    (cons 'let
          (cons
           (map (lambda (def) (list (car def) ''*unassigned*)) defs)
           (append
            (map (lambda (def) (list 'set! (car def) (cadr def))) defs)
            body)))))

(define exp '(letrec ((fact (lambda (n) (if (= n 1) 1 (* n (fact (- n 1))))))) (fact 10)))
;; (display (letrec->let exp))
;; (display (eval (letrec->let exp) user-initial-environment))

;; b
;; let can't work because the lambda in let is evaluated in the context of the enclosing
;; environment, in which the bindings of the lambda itself are not in place.
;; letrec first established the bindings then assigned the value, so when binding expressions
;; are evaluated, they can refer to bindings, this make recursive binding definition possible.
