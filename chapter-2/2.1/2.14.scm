(load "interval-arithmetic.scm")

(define i1 (make-center-percent 100 0.01))
(define i2 (make-center-percent 150 0.02))

(define (par1 i1 i2)
  (div-interval (mul-interval i1 i2) (add-interval i1 i2)))

(define (par2 i1 i2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one
     (add-interval
      (div-interval one i1)
      (div-interval one i2)))))

; We can see that Lem is right
; par1 and par2 return different results
(print-interval-center-percent (par1 i1 i2))
(newline)


(print-interval-center-percent (par2 i1 i2))
(newline)

; We can see that i2/i2 is not equal to 1.
; So the two formula are not the same.
(print-interval-center-percent (div-interval i1 i1))

