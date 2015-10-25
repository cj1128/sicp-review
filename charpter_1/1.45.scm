;; Exercise 1.45


;; fixed-point
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          guess
          (try next))))
  (try first-guess))

;; repeated-f
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated-f f n)
  (define (iterate g k)
    (if (= k n) g
        (iterate (compose f g) (+ k 1))))
  (iterate f 1))

;; average-damp
(define (average x y)
  (/ (+ x y) 2))
(define (average-damp f)
  (lambda (x)
    (average (f x) x)))

(define (cube-root x)
  (fixed-point
   (average-damp (lambda (y) (/ x (expt y 2))))
   1.0))

(define (test x n k)
  (fixed-point
   ((repeated-f average-damp k)
    (lambda (y) (/ x (expt y (- n 1)))))
    1.0))

;; 4th root -> 2 times average damp
;; 5th root -> 2 times average damp
;; 6th root -> 2 times average damp
;; 7th root -> 2 times average damp
;; 8th root -> 3 times average damp
;; 16th root -> 4 times average damp
;; (display (test 1000 16 4))

(define (nth-root x n)
  (define average-damping-times
    (ceiling (/ (log n) (log 2))))
  (fixed-point
   ((repeated-f average-damp average-damping-times)
    (lambda (y) (/ x (expt y (- n 1)))))
   1.0))

(display (nth-root 1000000000000 12))
