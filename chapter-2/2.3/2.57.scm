(load "sd-basic.scm")

(define (make-sum a1 a2)
  (cond
    ((=number? a1 0) a2)
    ((=number? a2 0) a1)
    ((and
       (number? a1)
       (number? a2))
     (+ a1 a2))
    (else
      (list '+ a1 a2))))

(define (sum? x)
  (and
    (pair? x)
    (eq? '+ (car x))))

(define (addend x)
  (cadr x))

(define (augend x)
  (if (= (length x) 3)
      (caddr x)
      (cons '+ (cddr x))))

(define (make-product m1 m2)
  (cond
    ((or (=number? m1 0)
         (=number? m2 0))
     0)
    ((=number? m1 1) m2)
    ((=number? m2 1) m1)
    ((and
       (number? m1)
       (number? m2))
     (* m1 m2))
    (else (list '* m1 m2))))

(define (product? x)
  (and
    (pair? x)
    (eq? '* (car x))))

(define (multiplier p)
  (cadr p))

(define (multiplicand p)
  (if (= 3 (length p))
      (caddr p)
      (cons '* (cddr p))))

(display (deriv '(* x y (+ x 3)) 'x))
