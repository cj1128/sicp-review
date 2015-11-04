;; Exercise 2.39
;; Using fold-right and fold-left to impolement reverse

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial
                      (cdr sequence)))))

(define (fold-left op initial seq)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial seq))

(define (reverse seq)
  (fold-right
   (lambda (x y)
     (append y (list x)))
   '() seq))

(define (reverse2 seq)
  (fold-left
   (lambda (x y)
     (cons y x))
   '()
   seq))

(define l '(1 2 3 4 5))

(display (reverse l))
(newline)

(display (reverse2 l))
