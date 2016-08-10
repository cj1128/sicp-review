;; Some stream utilities

(define (stream-add s1 s2)
  (stream-map + s1 s2))

(define (partial-sums s)
  (define result
    (cons-stream (stream-car s)
      (stream-add  result (stream-cdr s))))
  result)

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define (stream-scale s n)
  (stream-map (lambda (x) (* x n)) s))

(define (show-stream s n)
  (define (iter stream i)
    (if (< i n)
        (begin
          (display (stream-car stream))
          (newline)
          (iter (stream-cdr stream) (+ i 1)))))
  (iter s 0))
