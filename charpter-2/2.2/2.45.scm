;; Exercise 2.45
;; Define a general purpose procedure to produce right-spilit and up split

(define (split t1 t2)
  (define (procedure painter n)
    (if (= n 0)
        painter
        (t1
         painter
         (t2
          (procedure (- n 1))
          (procedure (- n 1))))))
  procedure)


