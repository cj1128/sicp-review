(load "compose.scm")

(define (inc x)
  (+ x 1))

(display ((compose square inc) 6))
