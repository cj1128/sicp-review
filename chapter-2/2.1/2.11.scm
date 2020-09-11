; For each interval, we have three cases for sign
; - All positive
; - All negative
; - All negative
; So in multiplication and division, we have nine cases to handle.
(define (mul-interval x y)
  ; 0: all positionve
  ; 1: lower is negative, upper is positive
  ; 2: all negative
  (define (get-sign interval)
    (let
      ((lower (lower-bound interval))
       (upper (upper-bound interval)))
      (cond
        ((>= lower 0) 0)
        ((<= upper 0) 2)
        (else 1))))

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
