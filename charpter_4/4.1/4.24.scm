;; Exercise 4.24
;; Design and carry out some experiments to compare the speed of
;; the original metacircular with the version in this section.

(load "../eval.scm")
(load "../eval-with-analyze.scm")
(load "../apply.scm")

(define exp-define '(define (factorial n)
                      (if (= n 1) 1 (* n (factorial (- n 1))))))
(define exp-exe '(factorial 100))

(define (loop proc n)
  (define (iter i)
    (if (< i n)
        (begin
          (proc)
          (iter (+ i 1)))))
  (iter 0))

(define (run proc)
  (let ((env (setup-environment)))
    (with-timings
     (lambda ()
       (proc exp-define env)
       (loop (lambda () (proc exp-exe env)) 50))
     (lambda (run-time gc-time real-time)
       (display "run time: ")
       (display run-time)
       (newline)
       (display "gc time: ")
       (display gc-time)
       (newline)
       (display "real time: ")
       (display real-time)
       (newline)
       ))))

(run eval)
(run eval-with-analyze)
