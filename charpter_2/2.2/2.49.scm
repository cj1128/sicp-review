;; Exercise 2.49
;; Use segments->painter to defien some primitive painters

(define draw-outline
  (segments->painter
   (list
    (make-segment
     (make-vect 0 0)
     (make-vect 0 1))
    (make-segment
     (make-vect 0 0)
     (make-vect 1 0))
    (make-segment
     (make-vect 1 0)
     (make-vect 1 1))
    (make-segment
     (make-vect 0 1)
     (make-vect 1 1)))))


(define draw-x
  (segments->painter
   (list
    (make-segment
     (make-vect 0 1)
     (make-vect 1 0))
    (make-segment
     (make-vect 0 0)
     (make-vect 1 1)))))

(define draw-diamond
  (segments->painter
   (list
    (make-segment
     (make-vect 0 0.5)
     (make-vect 0.5 1))
    (make-segment
     (make-vect 0.5 1)
     (make-vect 1 0.5))
    (make-segment
     (make-vect 1 0.5)
     (make-vect 0.5 0))
    (make-segment
     (make-vect 0.5 0)
     (make-vect 0 0.5)))))

;;We just ignore wave cause it's so many segments to be defined
