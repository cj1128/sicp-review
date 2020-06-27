;; Exercise 3.71
;; write a procedure to generate the Ramanujan numbers


(load "../stream/utils.scm")
(load "../stream/weighted-pairs.scm")

(define (weight p)
  (let ((i (car p)) (j (cadr p)))
    (+
      (* i i i)
      (* j j j))))

(define ints (integers-starting-from 1))

(define s (weighted-pairs ints ints weight))

(define (filter s)
  (let ((s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (if (= (weight s1) (weight s2))
        (cons-stream
          (weight s1)
          (filter (stream-cdr s)))
        (filter (stream-cdr s)))))

(define ramanujan (filter s))
(show-stream ramanujan 6)
