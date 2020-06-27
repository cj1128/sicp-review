;; Exercise 2.37
;; Implements matrix and vector math

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial
                      (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init
                        (map car seqs))
            (accumulate-n op init
                          (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (m-row)
         (dot-product m-row v))
       m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (m-row)
           (map (lambda (col)
                  (dot-product col m-row))
                cols)) m)))

(define m1 '((1 2 3 4) (5 6 7 8) (9 10 11 12)))
(define v1 '(1 2 3 4))
(define m2 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))

(display (dot-product '(1 2 3) '(4 5 6)))
(newline)

(display (matrix-*-vector m1 v1))
(newline)

(display (matrix-*-matrix m1 m2))
(newline)

(display (transpose m1))
