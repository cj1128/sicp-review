;; Exercise 3.39
;; List all the possibilities of the following procedure

(define x 10)
(define s (make-serializer))
(parallel-execute
  (lambda () (set! x ((s (lambda () (* x x))))))
  (s (lambda () (set! x (+ x 1)))))

;; - 121
;; - 101
;; - 100
