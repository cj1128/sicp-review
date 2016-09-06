;; Exercise 4.5
;; Modify the handling of cond so that is supports
;; the extended syntax

(define (cond-extended-clause? exp) (eq? (car (cond-actions exp)) '=>))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-caluse? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last: COND->IF" clauses))
            (if (cond-extended-clause? first)
                (make-if (cond-predicate first)
                         (list (caddr first) (cond-predicate first))
                         (expand-clauses rest))
                (make-if (cond-predicate first)
                         (sequence->exp (cond-actions first))
                         (expand-clauses rest)))))))

