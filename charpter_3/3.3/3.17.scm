;; Exercise 3.17
;; Devise a correct version of the count-pairs procedure
(define visited '())

(define (count pair)
  (if (or
        (not (pair? pair))
        (memq pair visited))
      0
      (begin
        (set! visited (cons pair visited))
        (count-pairs pair))))

(define (count-pairs x)
  (if (not (pair? x))
    0
    (+
      (count (car x))
      (count (cdr x))
      1)))

;; 3
(define p1 (cons 1 2))
(define p2 (cons 3 4))
(define p3 (cons p1 p2))
(display (count-pairs p3))
(newline)

;; 4
(define p1 (cons 1 2))
(define p2 (cons 3 p1))
(define p3 (cons p1 p2))
(display (count-pairs p3))
(newline)

;; 7
(define p1 (cons 1 2))
(define p2 (cons p1 p1))
(define p3 (cons p2 p2))
(display (count-pairs p3))
(newline)

;; never return, infinite recur
(define p1 (cons 1 2))
(define p2 (cons p1 3))
(set-car! p1 p2)
(define p3 (cons p1 p2))
(display (count-pairs p3))
(newline)
