;; Exercise 4.4
;; Install *and* and *or* as new special forms for the evaluator
;; Alternatively, show how to implemement *and* and *or* as
;; derived expressions

(define (and? exp) (tagged-list? exp 'and))

(define (eval-and exp env)
  (define (iter exps)
    (if (null? exps) 'true
        (if (true? (eval (car exps) env))
            (iter (cdr exps))
            'false)))
  (iter (cdr exp)))

(define (or? exp) (tagged-list? exp 'or))

(define (eval-or exp  env)
  (define (iter exps)
    (if (null? exps)
        'false
        (if (true? (eval (car exps) env))
            'true
            (iter (cdr exps)))))
  (iter (cdr exp)))


;; Implemement *and* and *or* as derived expressions

;(and exp1 exp2 exp3)
;(if exp1
;    (if exp2 (if exp3 'true 'false) 'fasle)
;    'false)
(define (and->if exp) (exapnd-and-clauses (cdr exp)))
(define (exapnd-and-clauses clauses)
  (if (null? clauses)
      'true
      (let ((first (car clauses)) (rest (cdr clauses)))
        (make-if first
                 (exapnd-and-clauses rest)
                 'false))))
(define (eval-and exp env) (eval-if (and->if exp) env))


;(or exp1 exp2 exp3)
;(if exp1 'true
;    (if exp2 'true (if exp3 'true 'false)))

(define (or->if exp) (exapnd-or-clauses (cdr exp)))
(define (exapnd-or-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses)) (rest (cdr clauses)))
        (make-if first
                 'true
                 (exapnd-and-clauses rest)))))
(define (eval-or exp env) (eval-if (or->if exp) env))


