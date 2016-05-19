;; Implements stream

;; (cons-stream)
;; it must a special form, otherwise b will be automatically evaluated
(define (cons-stream a b)
  (cons a (delay b)))

;; (stream-car)
(define (stream-car s)
  (car a))

;; (stream-cdr)
(define (stream-cdr s)
  (force (cdr s)))

;; the-empty-stream

;; stream-null?

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
        (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x) (newline) (display x))

;; utility functions
(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (stream-enumerate-interval low high)
  (if (> low high) the-empty-stream)
    (cons-stream low (stream-enumerate-interval (+ low 1) high)))

;; delay and force
(define (memo-proc proc)
  (let ((already-run? #f) (result #f))
    (lambda ()
      (if (not already-run?)
          (begin
            (set! already-run? #t)
            (set! result (proc))
            result)
          result))))

;; (delay <exp>) == (memo-proc (lambda() (exp)))
(define (force delayed-object) (delayed-object))
