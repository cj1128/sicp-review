;; Exercise 3.53
;; Describe the elements of the stream defined by

(define s (cons-stream 1 (add-stream s s)))

;; 1 2 4 8 16 32 64
