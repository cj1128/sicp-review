;; Exercise 2.9

(define (make-interval a b) (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))

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

(define (mul-interval x y)
  (let
      ((p1 (* (lower-bound x) (lower-bound y)))
       (p2 (* (lower-bound x) (upper-bound y)))
       (p3 (* (upper-bound x) (lower-bound y)))
       (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (get-width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define interval1 (make-interval 2 11))
(define interval2 (make-interval 3 6))

;(define interval1 (make-interval 1 10))
;(define interval2 (make-interval 2 5))

(display (get-width interval1))
(newline)
(display (get-width interval2))
(newline)
(display (get-width (add-interval interval1 interval2)))
(newline)
(display (get-width (sub-interval interval1 interval2)))
(newline)
(display (get-width (mul-interval interval1 interval2)))
