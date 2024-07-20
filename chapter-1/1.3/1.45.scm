(load "repeated.lib.scm")

(define (fixed-point f first-guess max-times)
  (define tolerance 0.00001)
  (define times 0)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess times)
    (if (> times max-times)
        (error "fixed-point could not find a result")
        (let ((next (f guess)))
          (if (close-enough? guess next)
              guess
              (try next (1+ times))))))
  (try first-guess 1))

(define (average-damp f)
  (lambda (x)
    (/ (+ (f x) x) 2)))

; Find nth root of x with k times average-damping
(define (test x n k)
  (fixed-point
    ((repeated average-damp k)
     (lambda (y) (/ x (expt y (- n 1)))))
    1.0
    10000))

; (display (test 100 3 1))
; (newline)

; (display (test 100 4 2))
; (newline)

; (display (test 100 5 2))
; (newline)

; (display (test 100 6 2))
; (newline)

; (display (test 100 7 2))
; (newline)

; (display (test 100 8 3))
; (newline)

; From above experiments, we can conclude that:
; 4th root -> 2 times average damp
; 5th root -> 2 times average damp
; 6th root -> 2 times average damp
; 7th root -> 2 times average damp
; 8th root -> 3 times average damp
; 16th root -> 4 times average damp
; nth root -> log2(n) times average damp

(define (nth-root x n)
  (define average-damping-times
    (ceiling (/ (log n) (log 2))))
  (fixed-point
    ((repeated average-damp average-damping-times)
     (lambda (y) (/ x (expt y (- n 1)))))
    1.0
    10000))

(display (nth-root 100 20))
