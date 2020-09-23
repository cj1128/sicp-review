(load "accumulate.scm")

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(display (map square '(1 2 3)))
(newline)

(display (append '(1 2) '(3 4)))
(newline)

(display (length '(1 2 3 4)))
(newline)
