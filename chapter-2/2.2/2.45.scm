(define (split t1 t2)
  (define (procedure painter n)
    (if (= n 0)
        painter
        (let ((smaller (procedure painter (-n 1))))
          (t1
            painter
            (t2 smaller smaller)))))
  procedure)

