;; Exercise 3.81
;; produce a stream formulation that operates on an input stream of
;; requests to generate a new random number or to reset the sequence

(load "../stream/utils.scm")

;; we define a custom random function to get the same output with
;; same input
(define (random x)
  (remainder (+ (* 13 x) 5) 24))

;(display (map random (iota 10)))

(define (random-stream seed)
  (define result
    (cons-stream
      (random seed)
      (stream-map
        random
      result)))
  result)

(define (rand seed requests)
  (define (iter randoms requests)
    (if (stream-null? requests)
        the-empty-stream
        (let ((r (stream-car requests)))
          (cond
            ((eq? r 'generate)
             (cons-stream
               (stream-car randoms)
               (iter (stream-cdr randoms) (stream-cdr requests))))
            ((eq? r 'reset)
             (iter (random-stream seed) (stream-cdr requests)))))))
  (iter (random-stream seed) requests))


(show-stream (rand 1000 (list->stream (list 'generate 'generate 'generate))) 3)
(newline)
(show-stream (rand 1000 (list->stream (list 'generate 'generate 'generate 'reset 'generate 'generate 'generate 'generate 'generate))) 8)
