(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))

(define (add-interval a b)
  (make-interval (+ (lower-bound a) (lower-bound b))
                 (+ (upper-bound a) (upper-bound b))))

(define (sub-interval a b)
  (make-interval (- (lower-bound a) (upper-bound b))
                 (- (upper-bound a) (lower-bound b))))

(define (mul-interval a b)
  (let
    ((p1 (* (lower-bound a) (lower-bound b)))
     (p2 (* (lower-bound a) (upper-bound b)))
     (p3 (* (upper-bound a) (lower-bound b)))
     (p4 (* (upper-bound a) (upper-bound b))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if
    (and (<= (lower-bound y) 0)
         (>= (upper-bound y) 0))
    (error "Can't divide a interval that spans 0")
    (mul-interval x
                  (make-interval
                    (/ 1.0 (upper-bound y))
                    (/ 1.0 (lower-bound y))))))

(define (get-width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define (print-interval x)
  (display "[")
  (display (lower-bound x))
  (display " : ")
  (display (upper-bound x))
  (display "]")
  (newline))
