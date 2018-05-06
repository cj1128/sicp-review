;; Exercise 3.80
;; write a procedure RLC that takes as arguments the parameters R, L and C
;; and the time increment dt.


(load "../stream/utils.scm")
(load "../stream/delayed-integral.scm")

(define (RLC R L C dt)
  (lambda (v0 i0)
    (define v
      (integral
        (delay (stream-scale i (/ -1 C)))
        v0
        dt))
    (define i
      (integral
        (delay
          (stream-add
            (stream-scale v (/ 1 L))
            (stream-scale i (/ (- R) L))))
        i0
        dt))
    (cons i v)))

(define result ((RLC 1 1 0.2 0.1) 10 0))
(show-stream (car result) 10)
(show-stream (cdr result) 10)
