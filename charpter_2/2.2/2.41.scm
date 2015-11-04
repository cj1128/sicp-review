;;Exercise 2.41
;; Write a procedure to find all ordered triples
;; of distinct positive integers i,j and k less than or equal
;; to a given integer n that sum to a given integer s

;; Assume i > j > k
(define (make-range start end)
  (if (> start end)
      '()
      (cons start
            (make-range (+ start 1) end))))

(define (flatmap proc seq)
  (fold-right append '() (map proc seq)))

(define (find-triples n s)
  (define (sum-equal? triple)
    (= (+ (list-ref triple 0)
          (list-ref triple 1)
          (list-ref triple 2))
       s))
  (define triples
    (flatmap
     (lambda (k)
       (flatmap (lambda (j)
              (map (lambda (i)
                     (list i j k))
                   (make-range (+ 1 j) n)))
            (make-range (+ 1 k) n))
       )
     (make-range 1 n)))
  (filter
   sum-equal?
   triples))

(display (find-triples 10 10))
