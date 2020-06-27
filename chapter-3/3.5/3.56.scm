;; Exercise 3.56
;; A famouns problem, is to enumerate, in ascending order,
;; without repetitions, all positive integers with no prime
;; factors other than 2,3 or 5

(define (stream-scale s n)
  (stream-map (lambda (x) (* x n)) s))

(define (merge s1 s2)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< s1car s2car)
                   (cons-stream
                     s1car
                     (merge (stream-cdr s1) s2)))
                  ((< s2car s1car)
                   (cons-stream
                     s2car
                     (merge (stream-cdr s2) s1)))
                  (else
                    (cons-stream
                      s1car
                      (merge (stream-cdr s1) (stream-cdr s2)))))))))


(define S (cons-stream 1 (merge (stream-scale S 2) (merge (stream-scale S 3) (stream-scale S 5)))))

(display (stream-ref S 3))

