;; Exercise 3.65
;; Use the series ln2=1 - 1/2 + 1/3 - 1/4 ... to compute three sequences of
;; approximations to that natural logarithm of 2


(load "../stream/utils.scm")

(define (log-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (log-summands (+ n 1)))))

(define log-stream
  (partial-sums (log-summands 1)))

(show-stream log-stream 10)
(newline)

(define (euler-transform s)
  (let ((s0 (stream-ref s 0)) ;; S[n-1]
        (s1 (stream-ref s 1)) ;; S[n]
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s))))) ;; S[n+1]

(show-stream (euler-transform log-stream) 10)
(newline)

(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))

(show-stream (accelerated-sequence euler-transform log-stream) 20)


