;; Exercise 3.16
;; Show that the count-pairs procedure is not correct
;; Draw box-and-pointer diagrams representing list structures made up
;; of exactly three pairs for which Been's procedure would return 3,
;; return 4, return 7 or never return at all

(define (count-pairs x)
  (if (not (pair? x))
    0
    (+
      (count-pairs (car x))
      (count-pairs (cdr x))
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
