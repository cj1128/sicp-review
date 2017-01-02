;; Exercise 4.29
;; Exhibit a program that you would expect to run much more
;; slowly without memoization than with memoization

(define (loop x)
  (define (iter n)
    (if (< n 100)
        (begin
          (display x)
          (iter (+ n 1)))))
  (iter 0))

(loop (some-very-expensive-function))


;; Also, consider the following action, where the id procedure
;; is defined as in Exercise 4.27 and count starts at 0
;; Give the responses both when the evaluator memoizes and when it does not
(define (square x) (* x x))
(square (id 10))
;; 100 both memoization and non-memoization
count
;; memoization: 1
;; non-memoization: 2
