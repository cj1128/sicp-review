;; Exercise 3.2
;; Write a procedure make-monitored that takes as input a precedure f,
;; and return a new procedure mf that keeps track of the number of times it
;; has been called


(define (make-monitored f)
  (let ((counter 0))
    (lambda (param)
      (cond
        ((eq? param 'how-many-calls?) counter)
        ((eq? param 'reset-count)
          (set! counter 0))
        (else
          (set! counter (+ counter 1))
          (f param))))))


(define s (make-monitored sqrt))
(display (s 100))
(newline)

(display (s 30))
(newline)

(display (s 20))
(newline)

(display (s 'how-many-calls?))
(newline)
