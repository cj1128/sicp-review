;; Exercise 2.48
;; Using vectors to define a representation for segments

(define (make-segment start end)
  (list start end))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cadr s))

