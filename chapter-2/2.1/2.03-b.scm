(define (make-rect x y width height)
  (cons (make-point x y) (make-point (+ x width) (+ y height))))

(define (rect-width rect)
  (- (x-point (cdr rect)) (x-point (car rect))))

(define (rect-height rect)
  (- (y-point (cdr rect)) (y-point (car rect))))
