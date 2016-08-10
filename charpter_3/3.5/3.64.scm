;; Exercise 3.64
;; Write a procedure stream-limit that takes as arguments a stream and
;; a number(the tolerance)


(load "../stream/utils.scm")

(define (stream-limit s t)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1)))
    (if (< (abs (- s0 s1)) t)
        s1
        (stream-limit (stream-cdr s) t))))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
   (define result
     (cons-stream 1.0
                  (stream-map (lambda (guess) (sqrt-improve guess x))
                              result)))
   result)

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

;(show-stream (sqrt-stream 5) 10)

(display (sqrt 5 0.0000001))

