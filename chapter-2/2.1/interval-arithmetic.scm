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

(define (print-interval-center-percent x)
  (display "[")
  (display (center x))
  (display " ± ")
  (display (* (percent x) 100))
  (display "%")
  (display "]")
  (newline))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

; p: 0 ~ 1
(define (make-center-percent c p)
  (define diff (* c p))
  (make-interval (- c diff) (+ c diff)))

(define (percent i)
  (/ (width i) (center i)))
