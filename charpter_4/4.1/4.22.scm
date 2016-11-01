;; Exercise 4.22
;; Extend the evaluator to support the special
;; form let

(define (analyze exp)
  (cons ((let? exp) (analyze-let exp))))

(define (analyze-let exp)
  (analyze-lambda (let->combination exp)))
