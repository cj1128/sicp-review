;; Exercise 2.12

(define (make-center-percent center percent)
  (make-interval
   (* center (- 1 percent))
   (* center (+ 1 percent))))

(define (percent interval)
  (/ (- (upper-bound interval) (center interval))
     (cneter interval)))
