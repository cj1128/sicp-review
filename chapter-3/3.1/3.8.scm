;; Exercise 3.8
;; Define a procedure f that shows subexpressions evaluation
;; order can make a big difference
;; (+ (f 0) (f 1))
;; evaluate from left to right -> 0
;; evaluate from right to left -> 1

(define (f arg)
  (let ((state 1))
    (if (= arg 0)
        (begin (set! state 0)
          state)
        state)))

;(display (f 1))
;(display (f 0))
(display (+ (f 0) (f 1)))

