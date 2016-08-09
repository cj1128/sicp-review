;; Exercise 3.58
;; Give an interpretation of the stream computed by the following procedure

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))

(define (stream-for-each s n proc)
  (define (iter i stream)
    (if (< i n)
      (begin
        (proc (stream-car stream))
        (iter (+ i 1) (stream-cdr stream)))))
  (iter 0 s))

(stream-for-each (expand 3 8 10) 10 (lambda (x) (newline) (display x)))


;; (expand 1 7 10): 1 4 2 8 5 7 1 4 2 8 5 7...
;; (expand 3 8 10): 3 7 5 0 0 ...


