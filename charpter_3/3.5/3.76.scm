;; Exercise 3.76
;; write a procedure smooth to process a stream
;; use smooth to implement the zero-crossing detector in a more modular style


(define (smooth stream last-value)
  (cons-stream
    (/ (+ (stream-car stream) last-value) 2)
    (smooth
      (stream-cdr stream)
      (stream-car stream))))

(define zero-crossings
  (let ((smoothed-data (smooth sense-data 0)))
    (stream-map
      sign-change-detector
      smoothed-data
      (cons-stream
        0
        smoothed-data))))
