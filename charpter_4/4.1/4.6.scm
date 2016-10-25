;; Exercise 4.6
;; Implements a syntactic transformation let->combination that
;; reduces evaluating let expressions to evaluating combinations

(define (let-vars exp)
  (map car (cadr exp)))
(define (let-exps exp)
  (map cadr (cadr exp)))
(define (let-body exp)
  (cddr exp))

(define (let->combination exp)
  (cons (make-lambda
          (let-vars exp)
          (let-body exp))
        (let-exps exp)))
