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

(display (fold-right list '() (list 1 2 3)))
(newline)

(display (fold-left list '() (list 1 2 3)))
(newline)

; For fold-left and fold-right to produce the same result
; op must satisfy *commutativity* and *associativity*.

; For one element sequence (e1)
; (fold-left op init '(e1)) = (op init e1)
; (fold-right op init '(e1)) = (op e1 init)
; If (op init e1) equals to (op e1 init)
; then op must have commutativity.

; For two elements sequence (e1 e2)
; (fold-left op init '(e1 e2)) = (op (op init e1) e2) = (op (op e1 init) e2) (using commutativity)
; (fold-right op init '(e1 e2)) = (op e1 (op e2 init)) = (op e1 (op init e2)) (using commutativity)
; If (op (op e1 init) e2) equals to (op e1 (op init e2))
; then op must have associativity.
