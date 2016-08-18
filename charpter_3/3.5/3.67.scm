;; Exercise 3.67
;; Modify the pairs procedure so that (pairs integers integers) will procedure
;; the stream of all pairs of integers(i,j)(without the condition i <= j)



(load "../stream/utils.scm")

(define ints (integers-starting-from 1))

;; procedure (i, j) with i <= j
(define (pairs1 s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs1 (stream-cdr s) (stream-cdr t)))))

;; procedure (i, j) with i > j
(define (pairs2 s t)
  (cons-stream
    (list (stream-ref s 1) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list x (stream-car t)))
                  (stream-cdr (stream-cdr s)))
      (pairs2 (stream-cdr s) (stream-cdr t))))
  )

(define int-pairs
  (interleave
    (pairs1 ints ints)
    (pairs2 ints ints)))

(show-stream int-pairs 30)
