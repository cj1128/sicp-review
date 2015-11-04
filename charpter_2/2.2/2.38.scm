;;Fold-left Implementation

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

(display (fold-right / 1 (list 1 2 3)))
(newline)

(display (fold-left / 1 (list 1 2 3)))
(newline)

(display (fold-left list '() (list 1 2 3)))
(newline)

(display (fold-left list '() (list 1 2 3)))
(newline)

;; as long as the (op x y) == (op y x)
;; then the fold-right and fold-left will produce the same result
