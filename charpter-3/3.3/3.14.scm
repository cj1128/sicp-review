;; Exercise 3.14
;; Explain what mystery does in general

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

(define v (list 'a 'b 'c 'd))
(define w (mystery v))

(display v)
(newline)

(display w)

;; From the output, we can easily find out that
;; what mystery does is making a reverse list from the argument
