;; Exercise 2.33
;; Definitions of some basic list-manipulation operations as accumulations

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op
       (car seq)
       (accumulate op initial (cdr seq)))))

(define (map p sequence)
  (accumulate (lambda (x y)
                (cons (p x) y))
              '() sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length seq)
  (accumulate (lambda (x y) (+ y 1))
              0 seq))

(define l '(1 2 3 4))
(display (map square l))
(newline)

(display (append (list 4 5 6 7) l))
(newline)

(display (length l))
