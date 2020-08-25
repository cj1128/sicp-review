(define (make-rect x y width height)
  (cons (make-point x y) (cons width height)))

(define (rect-width rect)
  (car (cdr rect)))

(define (rect-height rect)
  (cdr (cdr rect)))
