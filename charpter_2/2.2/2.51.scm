;; Exercise 2.51
;; Implements beside in two different ways
;; 1. writing a procedure that is analogous to the beside
;; 2. using beside and rotate to implement below

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((painter-top
           (transform-painter
            painter2
            split-point
            (make-vect 1.0 0.5)
            (make-vect 0.0 1.0)))
          (painter-bottom
           painter1
           (make-vect 0.0 0.0)
           (make-vect 1.0 0.0)
           split-point))
      (lambda (frame)
        (painter-top frame)
        (painter-bottom frame)))))

(define (below painter1 painter2)
  (rotate90
   (beside
    (rotate90 painter1)
    (rotate90 painter2))))
