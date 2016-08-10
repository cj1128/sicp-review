;; Exercise 3.62
;; Use the results of exercise 3.60 and exercise 3.61 to define a procedure
;; div-series that divides two power series


(define (div-series s1 s2)
  (let ((s2car (stream-car s2)))
    (if (= s2car 0)
        (error "denominator can't be 0")
        (mul-series
          s1
          (invert-unit-series s2)))))

;; generate tangent series
(define tangent-series (div-series sine-series cosine-series))
