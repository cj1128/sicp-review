;; Exercise 3.74
;; complete the program

(define zero-crossings
  (stream-map sign-change-detector
              sense-data
              (cons-stream
                0
                sense-data)))
