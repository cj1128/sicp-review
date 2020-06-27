;; Exercise 2.14

(define (make-interval a b) (cons a b))

(define (make-center-percent center percent)
  (make-interval
   (* center (- 1 percent))
   (* center (+ 1 percent))))

(define (center interval)
  (/ (+ (upper-bound interval) (lower-bound interval))
     2))

(define (percent interval)
  (/ (- (upper-bound interval) (center interval))
     (center interval)))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

(define (mul-interval x y)
  (let
      ((p1 (* (lower-bound x) (lower-bound y)))
       (p2 (* (lower-bound x) (upper-bound y)))
       (p3 (* (upper-bound x) (lower-bound y)))
       (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (sub-interval x y)
  (let (
        (p1 (- (lower-bound x) (lower-bound y)))
        (p2 (- (lower-bound x) (upper-bound y)))
        (p3 (- (upper-bound x) (lower-bound y)))
        (p4 (- (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (div-interval x y)
  (if
   (and (<= (lower-bound y) 0)
        (>= (upper-bound y) 0))
   (error "Can't divide a interval that spans 0")
   (mul-interval x
                 (make-interval
                  (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y))))))
(define (print-interval x)
  (display "[")
  (display (lower-bound x))
  (display " : ")
  (display (upper-bound x))
  (display "]")
  (newline))

(define (print-interval-center-percent x)
  (display (center x))
  (display " : ")
  (display (percent x))
  (newline))

(define i1 (make-center-percent 10 0.1))
(define i2 (make-center-percent 20 0.2))

(define (par1 i1 i2)
  (div-interval (mul-interval i1 i2) (add-interval i1 i2)))
(define (par2 i1 i2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one
     (add-interval
      (div-interval one i1)
      (div-interval one i2)))))

;; We can see that i2/i2 is not equal to 1. it's just an approximates to 1
(print-interval-center-percent (div-interval i2 i2))
(newline)

(print-interval-center-percent (par1 i1 i2))
(print-interval (par1 i1 i2))

(newline)

(print-interval-center-percent (par2 i1 i2))
(print-interval (par2 i1 i2))
