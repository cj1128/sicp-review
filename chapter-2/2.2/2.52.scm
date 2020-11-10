; a
; this one is trivial, just ignore.

; b
(define (corner-split painter n)
  (let
    ((up (up-split (- n 1)))
     (right (right-split (- n 1)))
     (corner (corner-split painter (- n 1))))
    (beside
      (below painter up)
      (below right corner))))

; c
(define (square-limit painter n)
  (let
    ((combined4
       identity
       flip-horiz
       flip-vert
       rotate180))))

