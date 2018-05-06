;; Exercise 2.6

;; A Church numeral is a procedure that takes one argument,
;; and that arugment is itself also a procedure that also takes
;; one argument. The procedure Zero represents the integer 0 by
;; returning a procedure that applies its input precedure 0 times.
;; the procedure One should return a procedure that applies its
;; input proccedure once, etc...

(define zero (lambda (f)
               (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f)
              (lambda (x) (f x))))

(define two (lambda (f)
              (lambda (x) (f (f x)))))

(define (++ l r) (lambda (f)
                  (lambda (x)
                    ((l f) ((r f) x)))))

;; use this to verify +
(define (inc x)
  (+ x 1))

(display ((one inc) 10))
(newline)
(display (((++ one two) inc) 10))

