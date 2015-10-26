;; Exercise 2.12

(define (make-interval a b) (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))

(define (div-interval x y)
(define (make-interval a b) (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))
  (if
   (and (<= (lower-bound y) 0)
       (>= (upper-bound y) 0))
   (error "Can't divide a interval that spans 0")
   (mul-interval x
                 (make-interval
                  (/ 1.0 (upper-bound y))
                  (/ 1.0 (lower-bound y))))))

(define (mul-interval x y)
  (let
      ((p1 (* (lower-bound x) (lower-bound y)))
       (p2 (* (lower-bound x) (upper-bound y)))
       (p3 (* (upper-bound x) (lower-bound y)))
       (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define interval1 (make-interval 2 11))
(define interval2 (make-interval 3 6))
(define interval3 (make-interval -3 6))
(display (div-interval interval1 interval2))
(display (div-interval interval1 interval3))
