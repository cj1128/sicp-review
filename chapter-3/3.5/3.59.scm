;; Exercise 3.59
;; a. define a procedure integrate-series

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

;; 1, 1/2, 1/3, 1/4, 1/5
(define s1
  (stream-map (lambda (x) (/ 1 x)) (integers-starting-from 1)))

(define (stream-mul s1 s2)
  (stream-map * s1 s2))

(define (integrate-series s)
  (stream-mul s s1))


;; b. show how to generate the series for sine and cosine

(define cosine-series (cons-stream 1 (stream-scale (integrate-series sine-series) -1)))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))
