;; Exercise 4.30
;; Cy D. Fect proposes to modify eval-sequence to use
;; actual-value rather than eval:

;(define (eval-sequence exps env)
;  (cond ((last-exp? exps) (eval (first-exp exps) env))
;        (else (actual-value (first-exp exps) env)
;              (eval-sequence (rest-exps exps) env))))

;; a
;; Ben Bitdiddle thinks Cy is wrong, he shows Cy the for-each procedure
;(define (for-each proc items)
;  (if (null? items)
;      'done
;      (begin (proc (car items))
;        (for-each proc (cdr items)))))
;; Explain why Ben is right about the behavior of for-each
;; Why not?

;; b
;; Cy agrees that Ben is right about the for-each example, but says that
;; that's not the kind of program he was thinking about when he proposed
;; his change to eval-sequence. He defines the following two procedures
;; in the lazy evaluator:

;(define (p1 x)
;  (set! x (cons x '(2)))
;  x)
;(define (p2 x)
;  (define (p e)
;    e
;    x)
;  (p (set! x (cons x '(2)))))

;; what are the values of (p1 1) and (p2 1) with the original
;; eval-sequence? What would the values be with Cy's proposed
;; change to eval-sequence?

;; with original eval-sequence
;; (p1 1)
;; (1 2)
;; (p2 1)
;; 1

;; with Cy's proposed change to eval-sequence
;; (p1 1)
;; (1 2)
;; (p2 1)
;; (1 2)

;; c
;; Cy also points out that changing eval-sequence doesn't affect
;; the behavior of the example in part a
;; Explain why this is true
;; Nothing to explain

;; d
;; How do you think sequences ought to be treated in the lazy evaluator?
;; It's all about side effects, actually, I think lazy evaluator can't allow
;; side effects, it would just cause confusion

