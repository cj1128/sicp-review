;; Exercise 3.51
;; what does the interpreter print in response to evaluating
;; each expression in the following sequence

(define (show x)
  (display-line x)
  x)

(define x
  （stream-map show (stream-enumerate-interval 0 10))

(stream-ref x 5)
(stream-ref x 7)

;; output:
;; after define
;; 0

;; after stream-ref 5
;; 1
;; 2
;; 3
;; 4
;; 5
;; after stream-ref 7
;; 6
;; 7
