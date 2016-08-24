;; Exercise 3.82
;; redo exercise 3.5 on monte carlo integration in terms of streams

(load "../stream/utils.scm")

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random (+ range 1)))))

(define (monte-carlo experiment-stream)
  (define (next experiment-stream total passed)
    (if (stream-car experiment-stream)
        (cons-stream
          (/ (+ passed 1) (+ total 1))
          (next (stream-cdr experiment-stream)
                (+ total 1)
                (+ passed 1)))
        (cons-stream
          (/ passed (+ total 1))
          (next
            (stream-cdr experiment-stream)
            (+ total 1)
            passed))))
  (next experiment-stream 0 0))

(define (experiment-stream p x1 y1 x2 y2)
  (define (exp)
    (let (
      (x (random-in-range x1 x2))
      (y (random-in-range y1 y2)))
      (p x y)))
  (define (result)
    (cons-stream
      (exp)
      (result)))
  (result))

(define (p x y)
  (<= (+
        (* x x)
        (* y y))
      1))

(define (integral-estimate-stream p x1 y1 x2 y2)
  (let ((width (- x2 x1))
        (height (- y2 y1)))
    (stream-map (lambda (x)
                  (*
                    (* width height 1.0)
                    x))
                (monte-carlo (experiment-stream p x1 y1 x2 y2)))))

(show-stream (integral-estimate-stream p -1 -1 1 1) 100)
;(show-stream (monte-carlo (experiment-stream p -1 -1 1 1)) 100)
