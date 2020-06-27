;; Exercise 2.44
;; Define the procedure up-split

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n1))))
        (beside painter
                (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter
               (beside smaller smaller)))))

