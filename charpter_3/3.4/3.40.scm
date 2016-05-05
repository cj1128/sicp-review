;; Exercise 3.40
;; Give all possible values of x that can result from following procedure

(define x 10)
(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))

;; - 100
;; - 1000
;; - 100 * 100 * 100 = 1000000
;; - 1000 * 1000 = 1000000
;; - 10 * 1000 = 10000
;; - 10 * 100 * 100 = 100000
;; - 10 * 10 * 100 = 10000

;; Which of these possibilities remain if we instead use serialized procedures
(define x 10)
(define s (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x x))))
                  (s (lambda () (set! x (* x x x)))))

;; - 100 * 100 * 100 = 1000000
;; - 1000 * 1000 = 1000000
