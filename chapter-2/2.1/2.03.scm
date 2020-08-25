(load "2.02.scm")

; Public interface
; - (make-rect topLeftX topLeftY width height)
; - (rect-width rect)
; - (rect-height rect)

; Use one representation
(load "2.03-a.scm")

; We can switch to another representation, and none of
; the usage code needs to be modified
;(load "2.03-b.scm")

(define (perimeter rect)
  (+
    (* 2 (rect-width rect))
    (* 2 (rect-height rect))))

(define (area rect)
  (* (rect-width rect) (rect-height rect)))

(define rect (make-rect 0 0 10 5))

(display (perimeter rect))
(newline)

(display (area rect))

