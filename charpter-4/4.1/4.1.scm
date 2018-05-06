;; Exercise 4.1
;; write a version of list-of-values that evaluates operands from left
;; to right regardless of the order of evaluation in the underlying lisp.
;; also write a version from right to left

;; from left to right
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((v (eval (first-operand exps) env)))
        (cons v (list-of-values (rest-operands exps) env)))))

;; from right to left
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((v (list-of-values (rest-operands exps) env)))
        (cons (eval (first-operand exps) env) v))))
