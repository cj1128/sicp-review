;; Exercise 3.5
;; Implement Monte Carlo integration as a procedure estimate-integral
;; that takes as arguments a predicate P, upper and lower bounds
;; x1,y1 and x2,y2 for the rectangle, and the number of trials
;; to perform in order to produce the estimate

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else (iter (- trials-remaining 1)
                      trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random (+ range 1)))))

(define (estimate-integral p x1 y1 x2 y2 trials)
  (define (exp)
    (let (
      (x (random-in-range x1 x2))
      (y (random-in-range y1 y2)))
      (p x y)))
  (let (
    (width (- x2 x1))
    (height (- y2 y1)))
    (*
      (* width height 1.0)
      (monte-carlo trials exp))))

(define (p x y)
  (<= (+
        (* x x)
        (* y y))
      1))

(display (estimate-integral p -1 -1 1 1 1000))
