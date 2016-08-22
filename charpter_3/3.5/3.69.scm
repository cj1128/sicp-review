;; Exercise 3.69
;; write a procedure triples that takes three infinite streams, S, T, and U,
;; and produces the stream of triples(Si,Tj,Uk) such that i <= j <= k.
;; use triples to generate the stream of all Pythagorean triples of positive
;; integers

(load "../stream/utils.scm")
(load "../stream/pairs.scm")

(define (triples S T U)
  (cons-stream
    (list
      (stream-car S)
      (stream-car T)
      (stream-car U))
    (interleave
      (stream-map (lambda (p)
        (list
          (stream-car S)
          (car p)
          (cadr p)))
        (stream-cdr (pairs T U)))
      (triples
        (stream-cdr S)
        (stream-cdr T)
        (stream-cdr U)))))

(define ints (integers-starting-from 1))
(show-stream (triples ints ints ints) 10)

(define pythagorean (stream-filter
                      (lambda (t)
                        (= (+
                            (square (car t))
                            (square (cadr t)))
                           (square (caddr t))))
                      (triples ints ints ints)))

(show-stream pythagorean 5)
