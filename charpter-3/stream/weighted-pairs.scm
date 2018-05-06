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
