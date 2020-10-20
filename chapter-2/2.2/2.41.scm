(load "flatmap.scm")

(define (make-range start end)
  (if (> start end)
      '()
      (cons start
            (make-range (+ start 1) end))))

; find triples (i, j, k) where 1 <= i < j < k <= n and i + j + k = s.
(define (find-triples n s)
  (define (sum-equal? triple)
    (= (+ (list-ref triple 0)
          (list-ref triple 1)
          (list-ref triple 2))
       s))

  (define triples
    (flatmap
      (lambda (i)
        (flatmap (lambda (j)
                   (map (lambda (k)
                          (list i j k))
                        (make-range (+ 1 j) n)))
                 (make-range (+ 1 i) n))
        )
      (make-range 1 n)))

  (filter
    sum-equal?
    triples))

(display (find-triples 10 10))
