;;We write some test programs here


;;Use Recursive Program to compute Fib numbers, it will be so slow
(define (fib n)
  (cond
    ((= n 1) 1)
    ((= n 2) 1)
    (else (+ (fib (- n 1)) (fib (- n 2))))))
(display (fib 32))