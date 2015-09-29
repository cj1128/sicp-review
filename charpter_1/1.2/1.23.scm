;;Exercise 1.23
;;(runtime) returns seconds in mit-scheme, so actually we can't
;;measure times cause they will all be 0

(define (smallest-divisor n)
  (find-divisor n 2))

(define (next test)
  (if (= test 2) 3 (+ 2 test)))

(define (find-divisor n test)
  (cond
   ((> (square test) n) n)
   ((= (remainder n test) 0) test)
   (else (find-divisor n (next test)))))

(display (smallest-divisor 19990))
