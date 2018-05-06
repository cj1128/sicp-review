;; Exercise 3.54
;; Complete the following definition of the stream whose nth element(counting from 0)
;; is n + 1 factorial

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define factorials
  (cons-stream 1 (mul-streams factorials (integers-starting-from 2))))

(display (stream-ref factorials 4))
