; The coordinate origin is at the *top-left*, just as the canvas

;
; Vector
;
(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2)
  (make-vect
    (+ (xcor-vect v1)
       (xcor-vect v2))
    (+ (ycor-vect v1)
       (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect
    (- (xcor-vect v1)
       (xcor-vect v2))
    (- (ycor-vect v1)
       (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect
    (* s (xcor-vect v))
    (* s (ycor-vect v))))

;
; Frame
;

; edge1 and edge2 are relative to the origin
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame f) (list-ref f 0))
(define (edge1-frame f) (list-ref f 1))
(define (edge2-frame f) (list-ref f 2))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
      (origin-frame frame)
      (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
                (scale-vect (ycor-vect v) (edge2-frame frame))))))

;
; Segment
;
(define (make-segment start end) (cons start end))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

;
; Painter transformers
;

(define (transform-painter painter origin edge1 edge2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame
                   new-origin
                   (sub-vect (m edge1) new-origin)
                   (sub-vect (m edge2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))


(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
            (transform-painter
              painter1
              (make-vect 0.0 0.0)
              split-point
              (make-vect 0.0 1.0)))
          (paint-right
            (transform-painter
              painter2
              split-point
              (make-vect 1.0 0.0)
              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((painter-top
            (transform-painter
              painter2
              split-point
              (make-vect 1.0 0.5)
              (make-vect 0.0 1.0)))
          (painter-bottom
            (transform-painter
              painter1
              (make-vect 0.0 0.0)
              (make-vect 1.0 0.0)
              split-point)))
      (lambda (frame)
        (painter-top frame)
        (painter-bottom frame)))))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

;
; Basic painters and helpers
; functions prefixed with `$` are provided by outside
;

(define (segments->painter segment-list)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (for-each
        (lambda (segment)
          ($line
            (m (start-segment segment))
            (m (end-segment segment))))
        segment-list))))

; (connect (a b c)) return two segments (a b) and (b c)
(define (connect vect-list)
  (define (iter segment-list remaining)
    (if (null? (cdr remaining))
        (reverse segment-list)
        (iter (cons (make-segment (car remaining)
                                  (cadr remaining))
                    segment-list)
              (cdr remaining))))
  (iter '() vect-list))

(define (wave frame)
  ((segments->painter (append (connect (list (make-vect 0.4  1.0)
                                             (make-vect 0.5  0.67)
                                             (make-vect 0.6  1.0))) ;inside legs
                              (connect (list (make-vect 0.25 1.0)
                                             (make-vect 0.33 0.5)
                                             (make-vect 0.3  0.4)
                                             (make-vect 0.1  0.6)
                                             (make-vect 0.0  0.4))) ;lower left
                              (connect (list (make-vect 0.0  0.2)
                                             (make-vect 0.1  0.4)
                                             (make-vect 0.33 0.35)
                                             (make-vect 0.4  0.35)
                                             (make-vect 0.35 0.2)
                                             (make-vect 0.4  0.0))) ;upper left
                              (connect (list (make-vect 0.75 1.0)
                                             (make-vect 0.6  0.55)
                                             (make-vect 1.0  0.85)));lower right
                              (connect (list (make-vect 1.0  0.65)
                                             (make-vect 0.8  0.35)
                                             (make-vect 0.6  0.35)
                                             (make-vect 0.65 0.2)
                                             (make-vect 0.6  0.0)))));upper right
   frame))
