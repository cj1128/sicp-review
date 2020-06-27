;; Exercise 2.11

;; (define (mul-interval x y)
;;   (let
;;       ((p1 (* (lower-bound x) (lower-bound y)))
;;        (p2 (* (lower-bound x) (upper-bound y)))
;;        (p3 (* (upper-bound x) (lower-bound y)))
;;        (p4 (* (upper-bound x) (upper-bound y))))
;;     (make-interval (min p1 p2 p3 p4)
;;                    (max p1 p2 p3 p4))))

(define (make-interval a b) (cons a b))
(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))

; 0: all positionve, 1 - 10
; 1: lower is negative, upper is positive, -1 - 10
; 2: all negative, -10 - -1

(define (get-sign interval)
  (let
      ((lower (lower-bound interval))
       (upper (upper-bound interval)))
    (cond
     ((>= lower 0) 0)
     ((<= upper 0) 2)
     (else 1))))

(define (mul-interval x y)
  (let
      ((sx (get-sign x))
       (sy (get-sign y))
       (lower-x (lower-bound x))
       (lower-y (lower-bound y))
       (upper-x (upper-bound x))
       (upper-y (upper-bound y)))
    (cond
     ((= sx 0)
      (cond
       ((= sy 0) (make-interval (* lower-x lower-y)
                                (* upper-x upper-y)))
       ((= sy 1) (make-interval (* upper-x lower-y)
                                (* upper-x upper-y)))
       ((= sy 2) (make-interval (* upper-x lower-y)
                                (* lower-x upper-y)))))
     ((= sx 1)
      (cond
       ((= sy 0) (make-interval (* lower-x upper-y)
                                (* upper-x upper-y)))
       ((= sy 1) (let
                     ((p1 (* lower-x lower-y))
                      (p2 (* lower-x upper-y))
                      (p3 (* upper-x lower-y))
                      (p4 (* upper-x upper-y)))
                   (make-interval (min p1 p2 p3 p4)
                                  (max p1 p2 p3 p4))))
       ((= sy 2) (make-interval (* upper-x lower-y)
                                (* lower-x lower-y)))))
     ((= sx 2)
      (cond
       ((= sy 0) (make-interval (* lower-x upper-y)
                                (* upper-x lower-y)))
       ((= sy 1) (make-interval (* lower-x upper-y)
                                (* lower-x lower-y)))
       ((= sy 2) (make-interval (* upper-x upper-y)
                                (* lower-x lower-y))))))))

(define (print-interval x)
  (display "[")
  (display (lower-bound x))
  (display " : ")
  (display (upper-bound x))
  (display "]")
  (newline))

(print-interval (mul-interval
                 (make-interval 1 10)
                 (make-interval 2 5)))

(print-interval (mul-interval
                 (make-interval 1 10)
                 (make-interval -2 5)))

(print-interval (mul-interval
                 (make-interval 1 10)
                 (make-interval -5 -2)))

(print-interval (mul-interval
                 (make-interval -1 10)
                 (make-interval 2 5)))

(print-interval (mul-interval
                 (make-interval -1 10)
                 (make-interval -2 5)))

(print-interval (mul-interval
                 (make-interval -1 10)
                 (make-interval -5 -2)))

(print-interval (mul-interval
                 (make-interval -10 -1)
                 (make-interval 2 5)))

(print-interval (mul-interval
                 (make-interval -10 -1)
                 (make-interval -2 5)))

(print-interval (mul-interval
                 (make-interval -10 -1)
                 (make-interval -5 -2)))

