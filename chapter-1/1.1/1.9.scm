;;Exercise 1.9

(define (A x y)
  (cond ((= y 0) 0)
    ((= x 0) (* 2 y))
    ((= y 1) 2)
    (else (A (- x 1) (A x (- y 1))))))

;(display (A 1 10))
;(display "\n")
;(display (A 2 4))
;(display "\n")
;(display (A 3 3))

(define (f n) (A 0 n)) ;;2 * n
(define (g n) (A 1 n)) ;;2^n
(define (h n) (A 2 n)) ;;(2^2^2^2...)(numbers of 2 is n)


(display (f 3))
(display "\n")
(display (g 5))
(display "\n")
(display (h 3))
