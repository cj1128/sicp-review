;; This procedure generates pairs stream
;; Want to generate a stream that contains the pairs
;; (i, j) with i <= j


(load "utils.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1) (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define ints (integers-starting-from 1))

(define int-pairs
  (pairs ints ints))

(show-stream int-pairs 30)

