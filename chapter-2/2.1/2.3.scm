;; Exercise 2.3

(define (make-point x y)
  (cons x y))
(define (point-x p)
  (car p))
(define (point-y p)
  (cdr p))

;; Representation 1
(define (make-rec x y width height)
  (cons (make-point x y) (cons width height)))

(define (rec-width rec)
  (car (cdr rec)))

(define (rec-height rec)
  (cdr (cdr rec)))


;; Representation 2
(define (make-rec x1 y1 x2 y2)
  (cons (make-point x1 y1) (make-point x2 y2)))
(define (rec-width rec)
  (- (point-x (cdr rec)) (point-x (car rec))))
(define (rec-height rec)
  (- (point-y (cdr rec)) (point-y (car rec))))

;; Uplevel functions
(define (perimeter rec)
  (+
   (* 2 (rec-width rec))
   (* 2 (rec-height rec))))
(define (area rec)
  (* (rec-width rec) (rec-height rec)))


(define rec (make-rec 0 0 10 5))
(display (perimeter rec))
(newline)
(display (area rec))

