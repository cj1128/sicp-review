;; Exercise 4.26

;; Show how to implement unless as a derived expression.

;; (unless condition usual-value exceptional-value)
;; (if (not condition) usula-value exceptional-value)

(define (eval exp env)
  (cond
   ...
   ((unless? exp) (eval (unless->if exp) env))))

(define (unless? exp) (tagges-list? exp 'unless))

(define (unless->if exp)
  (make-if
   (if-predicate exp)
   (if-alternative exp)
   (if-consequent exp)))

;; Alyssa syas that if unless is implemented as a special form, it would be
;; merely syntax, not a precedure that could be used in conjunction with
;; high-order procedures.

;; It's true, based on chartper 1, high-order procedures are procedures
;; that manipulate other procedures,
;; if unless is implemented as a special form, it is not a procedure
;; but a special keyword, can't pass it to high-order procedure.

;; Give an example of a situation where it might be useful to have unless
;; as a procedure, rather than as a special form

;; procedure can be passed around, but special form can't.
;; Following is a contrived example.

(define (h proc)
  (proc (= 0 0) 1 2))

(h unless)


