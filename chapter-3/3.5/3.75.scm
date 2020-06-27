;; Exercise 3.75
;; find the bug that Louis has installed and fix it

(define (make-zero-crossings input-stream last-avg last-value)
  (let ((avpt (/ (+ (stream-car input-stream) last-value)
                 2)))
    (cons-stream
      (sign-change-detector last-avg avpt)
      (make-zero-crossings
        (stream-cdr input-stream)
        avpt
        (stream-car input-stream)))))
