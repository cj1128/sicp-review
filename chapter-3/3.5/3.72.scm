;; Exercise 3.72
;; In a similar way to Exercise 3.71, generate a stream of all numbers
;; that can be written as the sum of two squares in three different ways
;; showing how they can be so writtten

(load "../stream/utils.scm")
(load "../stream/weighted-pairs.scm")

(define (weight p)
  (let ((i (car p)) (j (cadr p)))
    (+
      (square i)
      (square j))))

(define ints (integers-starting-from 1))

(define s (weighted-pairs ints ints weight))

(define (filter s)
  (let ((s1 (stream-ref s 1))
        (s2 (stream-ref s 2))
        (s3 (stream-ref s 3)))
    (if (= (weight s1) (weight s2) (weight s3))
        (cons-stream
          (list (weight s1) s1 s2 s3)
          (filter (stream-cdr s)))
        (filter (stream-cdr s)))))

(define result (filter s))
(show-stream result 5)

