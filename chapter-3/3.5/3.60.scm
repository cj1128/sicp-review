;; Exercise 3.60
;; Complete the definition of the following procedure for multiplying series

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

;; 1, 1/2, 1/3, 1/4, 1/5
(define s1
  (stream-map (lambda (x) (/ 1 x)) (integers-starting-from 1)))

(define (stream-mul s1 s2)
  (stream-map * s1 s2))

(define (integrate-series s)
  (stream-mul s s1))

(define cosine-series (cons-stream 1 (stream-scale (integrate-series sine-series) -1)))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (stream-scale s x)
  (stream-map (lambda (n) (* n x)) s))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1)
                  (stream-car s2))
               (add-streams (stream-scale (stream-cdr s1)
                                          (stream-car s2))
                            (mul-series s1
                                        (stream-cdr s2)))))

(define cos-square+sin-square
  (add-streams (mul-series cosine-series
                           cosine-series)
               (mul-series sine-series
                           sine-series)))

(define (show-stream s n)
  (define (iter stream i)
    (if (< i n)
        (begin
          (display (stream-car stream))
          (newline)
          (iter (stream-cdr stream) (+ i 1)))))
  (iter s 0))

(show-stream cos-square+sin-square 5)
