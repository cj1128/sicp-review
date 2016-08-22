;; Exercise 3.70
;; write a procedure merge-weighted that is like merge, except that
;; merge-weighted takes an additional argument weight

(load "../stream/utils.scm")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< (weight s1car) (weight s2car))
                   (cons-stream
                     s1car
                     (merge-weighted (stream-cdr s1) s2 weight)))
                  ((< (weight s2car) (weight s1car))
                   (cons-stream
                     s2car
                     (merge-weighted (stream-cdr s2) s1 weight)))
                  (else
                    (cons-stream
                      s1car
                      (merge-weighted (stream-cdr s1) s2 weight))))))))

(define (weighted-pairs s1 s2 weight)
  (cons-stream
    (list (stream-car s1) (stream-car s2))
    (merge-weighted
      (stream-map (lambda (x) (list (stream-car s1) x))
                  (stream-cdr s2))
      (weighted-pairs (stream-cdr s1) (stream-cdr s2) weight)
      weight)))

(define ints (integers-starting-from 1))

(define (weight-a p)
  (+ (car p) (cadr p)))

;; a
;(show-stream (weighted-pairs ints ints weight-a) 100)

;; b
;; first, let's create the stream in which each element can'be divisible
;; by 2, 3 or 5
(define s (stream-filter
            (lambda (x)
              (and
                (not (= (remainder x 2) 0))
                (not (= (remainder x 3) 0))
                (not (= (remainder x 5) 0))
                ))
            ints))
(define (weight-b p)
  (+
    (* 2 (car p))
    (* 3 (cadr p))
    (* 5 (car p) (cadr p))))

;(show-stream s 10)
(show-stream (weighted-pairs s s weight-b) 10)

