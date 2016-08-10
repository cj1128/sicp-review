;; A stream to calculate pi

(load "utils.scm")

(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (stream-scale (partial-sums (pi-summands 1)) 4))

;(show-stream pi-stream 10)


(define (euler-transform s)
  (let ((s0 (stream-ref s 0)) ;; S[n-1]
        (s1 (stream-ref s 1)) ;; S[n]
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s))))) ;; S[n+1]

;(show-stream (euler-transform pi-stream) 10)

(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))

(show-stream (accelerated-sequence euler-transform pi-stream) 10)
