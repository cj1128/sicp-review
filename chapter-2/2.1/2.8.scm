;; Exercise 2.8

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

(define (print-interval x)
  (display "[")
  (display (lower-bound x))
  (display " : ")
  (display (upper-bound x))
  (display "]"))

(define interval1 (make-interval 1 10))
(define interval2 (make-interval 2 5))
(display (print-interval (sub-interval interval1 interval2)))
(newline)
(display (print-interval (sub-interval interval2 interval1)))
