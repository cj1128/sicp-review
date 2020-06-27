;; Exercise 2.73
;; symbolic differentiation written in data-directed programming

(define (deriv exp var)
  (cond
   ((number? exp) 0)
   ((variable? exp)
    (if (same-variable? exp var) 1 0))
   (else ((get 'deriv (operator exp))
          (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))


;; a: number? and same-variable? are predicates, there is nothing to dispatch

;; b:
(define (install-sum)
  (define make-sum (addend augend)
    (list '+ addend augend))
  (define (addend operands)
    (car operands))
  (define (augend operands)
    (cadr operands))
  (define (handle-sum operands var)
    (make-sum
     (deriv (addend operands) var)
     (deriv (augend operands) var)))
  (put 'deriv '+ handle-sum))

(define (install-product)
  (define (multiplier operands)
    (car operands))
  (define (multiplicand operands)
    (cadr operands))
  (define (make-sum addend augend)
    (list '+ addend augend))
  (define (make-product multiplier multiplicand)
    (list '* multiplier multiplicand))
  (define (handle-product operands var)
    (make-sum
     (make-product
      (multipli operands)
      (deriv (multiplicand operands) var))
     (make-product
      (deriv (multiplier operands) var)
      (multiplicand operands))))
  (put 'deriv '* handle-product))

;; c:
(define (install-exponentiation)
  (define (base operands)
    (car operands))
  (define (exponent operands)
    (cadr operands))
  (define (make-product multiplier multiplicand)
    (list '* multiplier multiplicand))
  (define (make-exponentiation base expo)
    (list '** base expo))
  (define (handle-exponentiation operands var)
    (make-product
     (make-product
      (exponent operands)
      (make-exponentiation
       (base operands)
       (- (exponent operands) 1)))
     (deriv (base operands) var)))
  (put 'deriv '** handle-exponentiation))

;; d
;; the only thing to do is changing the order of arguments in procedure put
