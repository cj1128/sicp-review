;;Exercise 1.21

(define (smallest-divisor n)
  (find-divisor n 2))

(define (squrare n)
  (* n n))

(define (divide? test n)
  (= (remainder n test) 0))

(define (find-divisor n test)
  (cond
   ((> (square test) n) n)
   ((divide? test n) test)
   (else (find-divisor n (+ 1 test)))))

(display (smallest-divisor 199))
(display "\n")
(display (smallest-divisor 1999))
(display "\n")
(display (smallest-divisor 19999))
