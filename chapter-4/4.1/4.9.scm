;; Exercise 4.9
;; Design some iteration constructs, give examples of their use,
;; and show how to implement them as derived expressions
;; e.g. do, for, while, until

;; this is a for loop, for (var init final step) <body1> <body2>
;; we can translate it to named let
;; (for (i 0 10 1) (display i))
;; (let fn ((i 0)) (if (< i 10) (begin (display i) (fn (+ i 1)))))

(define (for? exp) (tagged-list exp 'for))
(define (for-var exp) (list-ref (cadr exp) 0))
(define (for-init exp) (list-ref (cadr exp) 1))
(define (for-final exp) (list-ref (cadr exp) 2))
(define (for-step exp) (list-ref (cadr exp) 3))
(define (for-body exp) (cdr exp))
(define (for->if exp)
  (make-if (list '< (for-var exp) (for-final exp))
           (sequency->exp
             (append
               (for-body exp)
               (list (list 'fn (list '+ (for-var exp) (for-step exp))))))))
(define (for->named-let exp)
  (cons 'let
        (cons 'fn
              (cons (list (list (for-var exp) (for-init exp))))
              (for->if exp))))


