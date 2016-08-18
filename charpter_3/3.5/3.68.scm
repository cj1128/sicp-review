;; Exercise 3.68
;; Does the following procedure work?

;; This can't work, cause pairs will call interleave infinitely and cause
;; maximum recursion depth exceeded

(load "../stream/utils.scm")

(define ints (integers-starting-from 1))

(define (pairs s t)
  (interleave
    (stream-map (lambda (x) (list (stream-car s) x)))
    (pairs (stream-cdr s) (stream-cdr t))))

(show-stream (pairs ints ints) 10)
