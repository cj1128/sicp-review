;; Exercise 2.52

;; we just ignore question 1

;; question 2
(define (corner-split painter n)
  (let
      ((up (up-split (- n 1)))
       (right (right-split (- n 1)))
       (corner (corner-split painter (- n 1))))
    (beside
     (below painter up)
     (below right corner))))


;; question 3

(define (square-limit painter n)
  (let
      ((combined4
        identity
        flip-horiz
        flip-vert
        rotate180))))

